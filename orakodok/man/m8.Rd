\name{m8}
\alias{m8}
\title{m8: 1. ZH mintasor megoldása (gss.csv)}
\description{
1.1 logikai vektor vs. szűrt data.frame; 1.2 elírás és felülírás; 2.1-2.6 import, NA-arány, tv_minutes, átlag feletti esetek, vallás és módusz, tv_kor és Pearson-korreláció.

A teljes kód lent, az \strong{Examples} részben van.
Konzolba kiírás: \code{kod("m8")}. Vissza a tartalomjegyzékhez: \code{\link{segits}}.
}

\section{Kifejtős válaszok}{
\strong{1.1} A \code{birthwt$smoke == 1} logikai (logical) vektor, minden sorra TRUE/FALSE
(189 elem). A \code{birthwt[birthwt$smoke == 1, ]} ezt sorszűrőként használja: az eredmény
data.frame, amelyben csak a dohányzó anyák sorai maradnak, minden oszloppal.

\strong{1.2} Nincs hiba. \code{testtomeg}: "András" (felülírtuk); \code{testomeg}: 82
(az elírás új változót hozott létre); \code{str(testtomeg)}: chr "András" (a típus számból
karakterre változott). Veszélyes, mert az R figyelmeztetés nélkül felülír, és egy elírás
csendben új objektumot hoz létre, így később rossz értékkel számolunk.

\strong{Figyelj:} a feladat \code{tv_hours}-t ír, de a változó neve \code{tvhours};
az elválasztó karaktert a \code{str()} kimenete alapján ellenőrizd.
}

\section{Többi oldal}{
\link{segits} | \link{m1} | \link{m2} | \link{m3} | \link{m4} | \link{m5} | \link{m6} | \link{m7} | \link{m8} | \link{m9} | \link{m10}
}
\examples{
\dontrun{
# 1. ZH (MINTASOR) - megoldás ------------------------------------------------

# 1. Kifejtős kérdések (a válaszokat kézzel kell a lapra írni, itt csak kipróbáljuk)

# 1.1 feladat --------------------------------------------------------------
data (birthwt , package = "MASS")

birthwt$smoke == 1                 # logikai (logical) vektor: minden sorra TRUE/FALSE
typeof (birthwt$smoke == 1)        # "logical"
birthwt [birthwt$smoke == 1 , ]    # data.frame: csak a dohányzó anyák sorai, minden oszloppal

# 1.2 feladat --------------------------------------------------------------
testtomeg <- 72
testomeg <- 82          # elírás -> új objektum jön létre, nincs hibaüzenet
testtomeg <- "András"   # felülírjuk, a típus is megváltozik (numeric -> character)
testtomeg               # "András"
testomeg                # 82
str (testtomeg)         # chr "András"


# 2. R programozási feladatok ------------------------------------------------

# 2.1 feladat - import -------------------------------------------------------
# getwd(); szükség esetén setwd("saját/útvonal")
list.files ()

gss <- read.csv (file = "gss.csv", sep = ";")   # ha vesszővel van elválasztva: sep = ","
# read.csv2 (file = "gss.csv")                  # ua. ;-s fájlra

str (gss)
dim (gss)
colnames (gss)
head (gss , n = 3)

# 2.2 feladat - hiányzó adatok a tévénézésnél --------------------------------
sum (is.na (gss$tvhours))          # hány db NA
mean (is.na (gss$tvhours))         # hány \% NA (arányként)
mean (is.na (gss$tvhours)) * 100   # százalékban

# 2.3 feladat - új változó: tévénézés percben --------------------------------
gss$tv_minutes <- gss$tvhours * 60
head (gss , n = 3)

# 2.4 feladat - hányan néznek az átlagosnál több tévét? ----------------------
mean (gss$tvhours , na.rm = T)     # átlag (NA-k nélkül)

gss$tvhours > mean (gss$tvhours , na.rm = T)       # logikai vektor
sum (gss$tvhours > mean (gss$tvhours , na.rm = T) ,
     na.rm = T)                                    # TRUE-k száma = válasz (fő)

# 2.5 feladat - vallási megoszlás (minőségi, nominális változó) --------------

# Analitikus eszközök
f <- table (gss$relig)        # abszolút gyakorisági sor
f
g <- prop.table (f)           # relatív gyakorisági sor
round (g , digits = 2)

# Grafikus eszköz: oszlopdiagram
barplot (f ,
         main = "Válaszadók vallás szerint" ,
         ylab = "gyakoriság [fő]" ,
         las = 2)             # függőleges feliratok, hogy olvashatók legyenek

# Középérték: nominális skála -> módusz (a leggyakoribb kategória)
# Eredmény (gss_cat adatain): Protestant, a válaszadók 50,49\%-a
f [f == max (f)]              # módusz és gyakorisága
names (f) [f == max (f)]      # módusz neve

# A leggyakoribb csoport aránya \%-ban
round (g [g == max (g)] * 100 , 2)

# 2.6 feladat - tévénézés és életkor kapcsolata ------------------------------

# új adatkeret: csak a két változó, csak a teljes sorok
tv_kor <- gss [ , c ("tvhours" , "age")]
tv_kor <- tv_kor [complete.cases (tv_kor) , ]
dim (tv_kor)
sum (is.na (tv_kor))          # ellenőrzés: 0 kell legyen

# Ábra: két mennyiségi változó -> pontdiagram
plot (tv_kor$age , tv_kor$tvhours ,
      xlab = "életkor" , ylab = "napi tévénézés [óra]")
abline (lm (tv_kor$tvhours ~ tv_kor$age))

# ugyanez ggplot2-vel (jitter, mert sok az egybeeső pont)
library (ggplot2)
ggplot (data = tv_kor , mapping = aes (x = age ,
                                       y = tvhours)) +
  geom_point (alpha = 0.3 , position = "jitter") +
  geom_smooth (method = "lm" , se = F) +
  theme_classic ()

# Pearson-féle korreláció
cor (tv_kor$age , tv_kor$tvhours)   # alapértelmezés: method = "pearson"

# Értelmezés (kommentben):
# Az r előjele adja az irányt (+ : idősebbek többet tévéznek),
# abszolút értéke az erősséget (0-0.3 gyenge, 0.3-0.7 közepes, 0.7 felett erős).
# Eredmény (gss_cat adatain): r = 0,14 -> gyenge pozitív kapcsolat; a pontfelhő nagyon szórt,
# a regressziós egyenes csak enyhén emelkedik.
}
}
