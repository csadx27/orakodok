\name{segits}
\alias{segits}
\alias{orakodok}
\alias{orakodok-package}
\docType{package}
\title{Tartalomjegyzék: órai R-kódok (Adatelemzés és adatvizualizáció R-ben)}
\description{
Kattints egy témára: a súgóoldal \strong{Examples} részében van a teljes kód.
}
\section{Témák}{
\itemize{
\item \code{\link{m1}} - \strong{1. óra: feltáró elemzés az Auto adatbázison}: dim, str, mean, median, var, sd, quantile, psych::describe; boxplot, hist, plot, lm + abline, pairs, GGally::ggpairs; adattípusok.
\item \code{\link{m2}} - \strong{1. óra (változat): R-alapok, ábrák, adattípusok, indexelés}: IQR, summary, feliratozott hisztogram, csoportos boxplot, regressziós egyenes, as.* konverziók, vektorok és data.frame indexelése.
\item \code{\link{m3}} - \strong{2. óra: vektor, mátrix, data.frame, faktor, szűrés (birthwt)}: getwd/setwd, names, paste, order, logikai indexelés, matrix, rowMeans, factor, table, prop.table, addmargins, cumsum, feliratozott barplot, szűrés & és | feltételekkel.
\item \code{\link{m4}} - \strong{3. óra: leíró statisztika és alapvető vizualizációk}: read.csv sep, is.na, complete.cases, átlagos imputálás, table, prop.table, barplot, factor, describe, quantile, hist, boxplot, cut, kereszttábla, mosaicplot, cor, cov, ggplot2, describeBy, write.csv.
\item \code{\link{m5}} - \strong{gss_cat: az órán feltett kérdések megoldása}: Fekete demokraták, vallás és rassz, családi állapot korosztályonként, válások rasszonként, jövedelem és tévénézés, jövedelem rasszonként, párt és vallás, életkor és vallás, házasok vs elváltak tévénézése.
\item \code{\link{m6}} - \strong{gss_cat: ZH-példák megoldása}: Tévénézés eloszlása (átlag vs medián, IQR, 15 óra felett), tv_kor adatkeret és korreláció, vallás megoszlása és módusz, vallas és fo_vallasok, életkor családi állapot szerint (ferdeség), korosztály és családi állapot.
\item \code{\link{m7}} - \strong{gss_cat: további gyakorló feladatok megoldása}: Életkor eloszlása, pártszimpátia (sorrend, df_party, factor nmax = 7, medián cumsum-mal), fő vallások és párt, jövedelem évenként, párt évenként, miért rossz a mean(as.numeric(rincome)).
\item \code{\link{m8}} - \strong{1. ZH mintasor megoldása (gss.csv)}: 1.1 logikai vektor vs. szűrt data.frame; 1.2 elírás és felülírás; 2.1-2.6 import, NA-arány, tv_minutes, átlag feletti esetek, vallás és módusz, tv_kor és Pearson-korreláció.
\item \code{\link{m9}} - \strong{Függvénypuska feladattípusonként}: Melyik feladathoz melyik órai függvény kell: import, NA, új változó, szűrés, minőségi és mennyiségi változók, kereszttábla, korreláció, melyik mutató melyik skálán.
\item \code{\link{m10}} - \strong{Üres sablon: a leíró elemzés fejezetszerkezete}: Az órán kiosztott üres script a négy alapkérdéssel (minőségi/mennyiségi, skála, ábra, mutató).
}
}
\section{Használat}{
\preformatted{library(orakodok)
?segits      # ez az oldal
?m4          # pl. a 3. óra kódja
kod()        # témák listája a konzolba
kod("m6")    # a teljes kód kiírása a konzolba
}
}
