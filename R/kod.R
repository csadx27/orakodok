TEMAK <- c(
  m1 = "1. \u00f3ra: felt\u00e1r\u00f3 elemz\u00e9s az Auto adatb\u00e1zison",
  m2 = "1. \u00f3ra (v\u00e1ltozat): R-alapok, \u00e1br\u00e1k, adatt\u00edpusok, indexel\u00e9s",
  m3 = "2. \u00f3ra: vektor, m\u00e1trix, data.frame, faktor, sz\u0171r\u00e9s (birthwt)",
  m4 = "3. \u00f3ra: le\u00edr\u00f3 statisztika \u00e9s alapvet\u0151 vizualiz\u00e1ci\u00f3k",
  m5 = "gss_cat: az \u00f3r\u00e1n feltett k\u00e9rd\u00e9sek megold\u00e1sa",
  m6 = "gss_cat: ZH-p\u00e9ld\u00e1k megold\u00e1sa",
  m7 = "gss_cat: tov\u00e1bbi gyakorl\u00f3 feladatok megold\u00e1sa",
  m8 = "1. ZH mintasor megold\u00e1sa (gss.csv)",
  m9 = "F\u00fcggv\u00e9nypuska feladatt\u00edpusonk\u00e9nt",
  m10 = "\u00dcres sablon: a le\u00edr\u00f3 elemz\u00e9s fejezetszerkezete"
)

kod <- function(tema = NULL) {
  if (is.null(tema)) {
    cat(paste0(format(names(TEMAK)), "  ", TEMAK), sep = "\n")
    cat("\nPl.: kod(\"m1\")   vagy   ?m1   vagy   ?segits\n")
    return(invisible(names(TEMAK)))
  }
  if (!tema %in% names(TEMAK)) {
    stop("Nincs ilyen t\u00e9ma: ", tema, ". Lehet: ", paste(names(TEMAK), collapse = ", "))
  }
  fajl <- system.file("scripts", paste0(tema, ".R"), package = "orakodok")
  sorok <- readLines(fajl, encoding = "UTF-8")
  cat(sorok, sep = "\n")
  invisible(sorok)
}
