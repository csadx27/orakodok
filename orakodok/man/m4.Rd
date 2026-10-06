\name{m4}
\alias{m4}
\title{m4: 3. óra: leíró statisztika és alapvető vizualizációk}
\description{
read.csv sep, is.na, complete.cases, átlagos imputálás, table, prop.table, barplot, factor, describe, quantile, hist, boxplot, cut, kereszttábla, mosaicplot, cor, cov, ggplot2, describeBy, write.csv.

A teljes kód lent, az \strong{Examples} részben van.
Konzolba kiírás: \code{kod("m4")}. Vissza a tartalomjegyzékhez: \code{\link{segits}}.
}

\section{Többi oldal}{
\link{segits} | \link{m1} | \link{m2} | \link{m3} | \link{m4} | \link{m5} | \link{m6} | \link{m7} | \link{m8} | \link{m9} | \link{m10}
}
\examples{
\dontrun{
# R-alapok ----------------------

# Ez a sor csak komment: az R nem futtatja.
# A parancsokat RStudio-ban szakaszonként érdemes futtatni.
# Csomagtelepítés (csak egyszer, ha szükséges):
# install.packages (c ("ISLR" , "psych" , "GGally" , "MASS" , "psych"))
# A munkakönyvtár gépenként eltér: getwd(); szükség esetén setwd("saját/útvonal").

# RStudio: Ctrl+Enter futtat; Ctrl+L törli a konzol kijelzőjét;
# Alt+- beszúrja a <- jelet; Ctrl+Shift+C ki-/bekommentez;
# Ctrl+Shift+R fejezetcímet hoz létre; Alt+Shift+Fel/Le másolja a sort.


# import ------------------------------------------------------------------

df <- read.csv (file = "2026_idomerleg.txt", sep= ";") # ;-vel van elválasztva
#read.csv2 (file = "2026_idomerleg.txt") #ua.
list.files ()

# hiányzó adatok kezelése --------------------------------------------------

str (df)
dim (df)
colnames (df)

mean (df$suly)        # NA fertőző a műveletekben
sum (is.na (df$suly))  # hány db NA
mean (is.na (df$suly)) # hány\% NA

is.na (df)
sum (is.na (df)) # az adatbázisban mennyi NA van?
mean (!is.na (df)) 

# hol vannak értékek:
!is.na (df$suly)

complete.cases (df) # adott sor teljes-e (nincs NA benne)

# adatbázis hiánytalan sorokkal - teljes, nincs NA

teljes_df <- df [ complete.cases (df) , ]

# átlaggal történő imputálás, új imputált változó létrehozása

df$suly_imp <-  ifelse (is.na (df$suly) , 
                        mean (df$suly, na.rm = T) , 
                        df$suly)

mean (df$suly)
mean (df$suly_imp)
mean (df$suly , na.rm = T) # na.rm argumentum kezeli a hiányzó értékeket, nélkülük számol


# Deskriptív statisztika 1. kérdésfeltevések ------------------------------

  # Minőségi vagy mennyiségi változó(k)?
  # Milyen skálán mérjük a változó(ka)t? - nominális / ordinális / intervallum / arány.
  # Mi a megfelelő ábra?
  # Mi a megfelelő mutató(k)?


# Minőségi változó egyváltozós elemzése ---------------------------------------------------

df$teleptip

# Analitikus eszközök
f <- table (df$teleptip) # absz.gyak.sor: f
# módusz: 3 - többi város
g <- prop.table (f)         # relatív gyakorisági sor: g
round (g , digits = 2)
?round # alapbeállítás?


# Grafikus eszközök: oszlopdiagram
barplot (f)   # fő
barplot (g)   # \%


plot (df$teleptip) # így nem működik, mert integer vektor

df$telepulestipus <- 
                    factor (df$teleptip ,
                            levels = c(1 , 2 , 3 , 4) , # 1:4
                            labels = c("Bp" , "MegyeV" , "TV" , "Kozseg") )
# as.factor (df$teleptip) 
plot (df$telepulestipus ) # így már működik, mert faktor

# intelligens alapbeállítás, az objektum típusától függ:
summary (df$telepulestipus) # factor: gyakoriságok
summary (df$teleptip)       # integer: kvartilisek


# Mennyiségi változó egyváltozós elemzése ---------------------------------


# Analitikus eszközök
psych::describe (df$ev)
quantile (df$ev , na.rm = T)
quantile (df$ev , probs = seq(0 , 1 , 0.1) , na.rm = T) # decilisek

# Grafikus eszközök
hist (df$ev)
hist (df$ev , breaks = 5)
hist (df$ev , breaks = 35 , freq = F)
hist (df$ev , breaks = 75)
?hist

boxplot (df$ev)


# Minőségi változók kétváltozós elemzése ----------------------------------

# folytonos mennyiségi változóból ordered factort hozunk létre:
df$korosztaly <-  factor (cut (x = df$ev , breaks = c (0 , 30 , 60 , 200 )) ,
                          labels = c ("fiatal" , "középkorú" , "idős"),
                          ordered = T)
                          
# Analitikus eszközök: kereszttábla
t <- table (df$teleptip , df$korosztaly)  # 1. a sorban 2. az oszlopban
round (prop.table (t , margin = 1) , 2)   # soronként \%-ol
round (prop.table (t , margin = 2) , 2)   # oszloponként

# Grafikus eszközök
barplot (t)        # halmozott oszlopdiagram (azonos szélesség)
mosaicplot (t)    


# Mennyiségi változók kétváltozós elemzése --------------------------------

# Analitikus eszközök
cor (df$magassag , df$suly , use = "pairwise.complete.obs") # na.rm helyett: a páronként teljes adatokra számolja ki r-t
?cor
cov (df$magassag , df$suly , use = "pairwise.complete.obs")


# Grafikus eszközök
plot (df$magassag , df$suly)

# GGPLOT2  --------------------------------

install.packages ("ggplot2")
library (ggplot2)

ggplot (data = df)

ggplot (data = df , mapping = aes (x = magassag ,
                                   y = suly)) +
  geom_point () 

# számít a sorrend, ami korábban jön, az van "alul"
# és rákerül a következő "layer", ami takarhatja
ggplot (data = df , mapping = aes (x = magassag ,
                                   y = suly)) +
  geom_point (alpha = 1 , position = "jitter") +
  geom_smooth (method = "lm" , se = F)
ggplot (data = df , mapping = aes (x = magassag ,
                                   y = suly)) +
  geom_smooth (method = "lm" , se = F) +
  geom_point (alpha = 1 , position = "jitter") 


ggplot (data = df , mapping = aes (x = magassag ,
                                   y = suly,
                                   col = ev)) +
  geom_smooth (method = "lm" , se = F) +
  geom_point (alpha = 0.3 , position = "jitter") +
  facet_wrap (~ teleptip) +
  theme_classic()

# https://r4ds.hadley.nz/data-visualize.html


# Mennyiségi és minőségi változók kétváltozós elemzése --------------------------------

# Analitikus eszközök
psych::describeBy (df$ev , group = df$teleptip)

# coefV, relatív szórás \%-os
18.22 /50.73

# Grafikus eszközök

boxplot (df$ev ~ df$teleptip , varwidth = T)





# export ------------------------------------------------------------------

write.csv (x = df , file = "idomerleg_3ujvaltozoval.csv") # ez most ,-vel van elválasztva


### gyakorláshoz adatbázis
forcats::gss_cat
data (gss_cat , package = 'forcats')
}
}
