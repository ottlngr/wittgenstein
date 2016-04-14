# PREPARE THE RAW TXT FILE FOR
# TRACTATUS LOGICO-PHILOSPHICUS (INTRODUCTION) - LUDWIG WITTGENSTEIN
# TAKEN FROM PROJECT GUTENBERG

tlp_intro_raw <- system.file("extdata", "tlp.txt", package = "wittgenstein")
tlp_intro_raw <- readLines(tlp_intro_raw)
tlp_intro_raw <- tlp_intro_raw[51:109]
tlp_intro <- tlp_intro_raw[nchar(tlp_intro_raw) > 0]
tlp_intro_raw <- NULL

devtools::use_data(tlp_intro, overwrite = T)

