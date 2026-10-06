\name{m6}
\alias{m6}
\title{m6: gss_cat: ZH-példák megoldása}
\description{
Tévénézés eloszlása (átlag vs medián, IQR, 15 óra felett), tv_kor adatkeret és korreláció, vallás megoszlása és módusz, vallas és fo_vallasok, életkor családi állapot szerint (ferdeség), korosztály és családi állapot.

A teljes kód lent, az \strong{Examples} részben van.
Konzolba kiírás: \code{kod("m6")}. Vissza a tartalomjegyzékhez: \code{\link{segits}}.
}

\section{Adatok}{
\code{data(gss_cat, package = "forcats")} - előtte egyszer: \code{install.packages("forcats")}.
A kommentekben lévő EREDMÉNY / VÁLASZ számokat a gss_cat adatain futtatva ellenőriztük.
}

\section{Többi oldal}{
\link{segits} | \link{m1} | \link{m2} | \link{m3} | \link{m4} | \link{m5} | \link{m6} | \link{m7} | \link{m8} | \link{m9} | \link{m10}
}
\examples{
\dontrun{
# GSS_CAT: ZH-PÉLDÁK megoldása -------------------------------------------------

# install.packages ("forcats")   # csak egyszer
data (gss_cat , package = "forcats")
df <- gss_cat
str (df)


# Z1. Mennyi tévét néznek a válaszadók? ----------------------------------------

# mennyiségi (arány skálájú) változó -> hisztogram, boxplot
psych::describe (df$tvhours)
summary (df$tvhours)
quantile (df$tvhours , na.rm = T)
IQR (df$tvhours , na.rm = T)

hist (df$tvhours , breaks = 24 ,
      main = "Napi tévénézés eloszlása" ,
      xlab = "óra" , ylab = "gyakoriság" , col = "lightblue")
boxplot (df$tvhours , horizontal = T)

# hányan néznek 15 óránál többet? (logikai vektor, mint az NA-számolásnál)
sum (df$tvhours > 15 , na.rm = T)

# VÁLASZ:
# átlag 2,98 óra, medián 2 óra, szórás 2,59, IQR 3 (Q1 = 1, Q3 = 4), ferdeség 2,92.
# Az eloszlás erősen jobbra ferde (néhányan nagyon sokat tévéznek, max. 24 óra),
# ezek a kiugró értékek felhúzzák az átlagot -> a MEDIÁN jellemzi jobban a tipikus
# tévénézést. Mellé az interkvartilis terjedelem (IQR) a jó szóródási mutató,
# mert az sem érzékeny a kiugró értékekre.
# 15 óránál többet 60 fő néz.


# Z2. Tévénézés és életkor ------------------------------------------------------

tv_kor <- df [ , c ("tvhours" , "age")]
tv_kor <- tv_kor [complete.cases (tv_kor) , ]
nrow (tv_kor)
nrow (tv_kor) / nrow (df) * 100        # a válaszadók hány \%-a válaszolt mindkettőre

plot (tv_kor$age , tv_kor$tvhours ,
      xlab = "életkor" , ylab = "napi tévénézés [óra]")
abline (lm (tv_kor$tvhours ~ tv_kor$age))

library (ggplot2)
ggplot (data = tv_kor , mapping = aes (x = age ,
                                       y = tvhours)) +
  geom_point (alpha = 0.3 , position = "jitter") +
  geom_smooth (method = "lm" , se = F) +
  theme_classic ()

cor (tv_kor$age , tv_kor$tvhours)      # Pearson r

# VÁLASZ:
# 11 299 teljes sor, a válaszadók 52,6\%-a válaszolt mindkét kérdésre.
# r = 0,14: pozitív irányú (idősebbek kicsit többet tévéznek), de nagyon gyenge
# kapcsolat; a pontfelhő szórt, az egyenes csak enyhén emelkedik.


# Z3. Vallási hovatartozás ------------------------------------------------------

# minőségi, nominális változó -> oszlopdiagram, gyakoriság, megoszlás, módusz
f <- table (df$relig)            # abszolút gyakoriság
f
g <- prop.table (f)              # relatív gyakoriság
round (g , digits = 3)

barplot (f , las = 2 , main = "Vallási hovatartozás" , ylab = "gyakoriság [fő]")

names (f) [f == max (f)]                 # módusz
round (g [g == max (g)] * 100 , 2)       # leggyakoribb csoport \%-a

# VÁLASZ:
# Nominális skála -> csak a MÓDUSZ értelmezhető: a leggyakoribb kategória.
# Módusz: Protestant (10 846 fő), a válaszadók 50,49\%-a.

# vallas: karakter típusú másolat
df$vallas <- as.character (df$relig)
str (df$vallas)

# két legnagyobb csoport: Protestant és Catholic (lásd f), a többi "egyéb"
df$fo_vallasok <- ifelse (df$vallas == "Protestant" | df$vallas == "Catholic" ,
                          df$vallas ,
                          "egyéb")
table (df$fo_vallasok)
round (prop.table (table (df$fo_vallasok)) , 2)
barplot (table (df$fo_vallasok) , main = "Fő vallási csoportok" ,
         ylab = "gyakoriság [fő]")
# Protestant 10 846 (50\%), Catholic 5124 (24\%), egyéb 5513 (26\%)


# Z4. Életkor családi állapot szerint ("No answer" nélkül) ---------------------

df_marital <- df [df$marital != "No answer" , ]
df_marital$csaladi <- factor (df_marital$marital)   # az üres "No answer" szint eltűnik
table (df_marital$csaladi)

psych::describeBy (df_marital$age , group = df_marital$csaladi)
boxplot (df_marital$age ~ df_marital$csaladi , varwidth = T ,
         xlab = "" , ylab = "életkor")

# VÁLASZ (skew oszlop):
# a két legaszimmetrikusabb csoport: Never married (ferdeség 1,19) és
# Widowed (ferdeség -0,94).
# Never married: átlag 33,95 > medián 30 -> jobbra (pozitívan) ferde.
# Widowed: átlag 71,71 < medián 74 -> balra (negatívan) ferde.
# Szabály: jobbra ferde eloszlásnál átlag > medián, balra ferdénél átlag < medián,
# mert az átlagot a hosszú farok felé húzzák a szélső értékek.


# Z5. Korosztály és családi állapot ---------------------------------------------

df$korosztaly <-  factor (cut (x = df$age , breaks = c (0 , 30 , 60 , 200 )) ,
                          labels = c ("fiatal" , "középkorú" , "idős"),
                          ordered = T)
table (df$korosztaly)

t <- table (df$korosztaly , df$marital)
t                                         # darabszámok
round (prop.table (t , margin = 1) , 2)   # korosztályonként \%

barplot (prop.table (table (df$marital , df$korosztaly) , margin = 2) ,
         main = "Családi állapot korosztályonként" , ylab = "arány")
mosaicplot (t)

# VÁLASZ:
# ARÁNYOKAT érdemes összehasonlítani, mert a korosztályok mérete eltér
# (fiatal 4249, középkorú 12159, idős 4999 fő), a darabszámok ezt tükröznék.
# A fiatalok 66\%-a még nem házasodott, a középkorúak 55\%-a, az idősek 46\%-a házas,
# az idősek 30\%-a özvegy.
# Skála: az életkor arány skálájú (mennyiségi) volt, a korosztály ORDINÁLIS
# (minőségi, sorrendezhető). Elveszett információ: a csoporton belüli pontos
# életkor és a különbségek nagysága (pl. 31 és 59 év ugyanaz a "középkorú").
}
}
