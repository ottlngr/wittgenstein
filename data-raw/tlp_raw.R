# PREPARE THE RAW TXT FILE FOR
# TRACTATUS LOGICO-PHILOSPHICUS - LUDWIG WITTGENSTEIN
# TAKEN FROM PROJECT GUTENBERG

tlp_raw <- system.file("extdata", "tlp.txt", package = "wittgenstein")
tlp_raw <- readLines(tlp_raw)
tlp_raw <- tlp_raw[112:3070]
tlp <- data.frame(tlp_raw, id = NA, text = NA)
tlp$id <- str_extract(tlp_raw, "[0-9.]*")
tlp$text <- str_extract(tlp_raw, "[^0-9.].*")
tlp <- tlp[complete.cases(tlp),]
tlp$text <- ifelse(tlp$id == "'", paste("'", tlp$text, sep=""), tlp$text)
tlp$text <- ifelse(tlp$id == "...", paste("...", tlp$text, sep=""), tlp$text)
tlp$text <- ifelse(tlp$id == ".", paste(".", tlp$text, sep=""), tlp$text)
tlp$id <- ifelse(tlp$id == "'", "", tlp$id)
tlp$id <- ifelse(tlp$id == "...", "", tlp$id)
tlp$id <- ifelse(tlp$id == ".", "", tlp$id)

for (i in 1:length(tlp$id)) {
  tlp[i,]$id <- ifelse(tlp[i,]$id == "", tlp[i-1,]$id, tlp[i,]$id)
}
tlp2 <- data.frame(id = as.character(unique(tlp$id)), text = NA)
for (i in as.character(tlp2$id)) {
   tlp2[tlp2$id == i,]$text <- paste0(tlp[tlp$id == i,]$text, sep = "", collapse = " ")
}
tlp2$text <- trimws(tlp2$text, "both")
tlp2$id <- as.character(tlp2$id)

tlp2[1,]$text <- "The world is all that is the case."

tlp <- tlp2
tlp2 <- NULL
tlp_raw <- NULL

devtools::use_data(tlp, overwrite = T)

