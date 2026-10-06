# PUSKA - csak órán használt függvények ---------------------------------------

# Import / export ---------------------------------------------------------------
getwd ()                                      # hol vagyok?
setwd ("S:/2026 R")                           # \ helyett /
list.files ()                                 # milyen fájlok vannak itt?
df <- read.csv (file = "adat.txt", sep = ";") # ;-vel elválasztott fájl
df <- read.csv2 (file = "adat.txt")           # ua.
write.csv (x = df , file = "uj.csv")          # export (,-vel elválasztva)
data (Auto)                                   # library (ISLR) után
data (birthwt , package = "MASS")
data (gss_cat , package = "forcats")

# Ismerkedés az adattal ----------------------------------------------------------
str (df) ; dim (df) ; nrow (df) ; ncol (df) ; colnames (df)
head (df , n = 3) ; summary (df)

# Hiányzó adatok -----------------------------------------------------------------
sum (is.na (df$x))           # hány db NA
mean (is.na (df$x))          # NA aránya (* 100 -> %)
sum (is.na (df))             # összes NA az adatbázisban
complete.cases (df)          # teljes-e a sor
teljes_df <- df [complete.cases (df) , ]
mean (df$x , na.rm = T)      # NA nélkül számol
df$x_imp <- ifelse (is.na (df$x) , mean (df$x , na.rm = T) , df$x)  # átlagos imputálás

# Új változó, faktor, kategorizálás ----------------------------------------------
df$perc <- df$ora * 60
df$tipus <- factor (df$kod , levels = 1:3 , labels = c ("a" , "b" , "c"))
df$korosztaly <- factor (cut (x = df$ev , breaks = c (0 , 30 , 60 , 200)) ,
                         labels = c ("fiatal" , "középkorú" , "idős") ,
                         ordered = T)

# Szűrés, oszlopok kiválasztása --------------------------------------------------
df$x == 1                                  # logikai vektor
df [df$x == 1 , ]                          # sorok szűrése
df [df$x == 1 & df$y == 1 , ]              # ÉS
df [df$x == 1 | df$y == 1 , ]              # VAGY
df [ , c ("x" , "y")]                      # csak két oszlop
sum (df$x > mean (df$x , na.rm = T) , na.rm = T)  # hány átlag feletti eset

# Minőségi változó (nominális / ordinális) ---------------------------------------
f <- table (df$tipus)            # abszolút gyakoriság
g <- prop.table (f)              # relatív gyakoriság
round (g , digits = 2)
cumsum (f)                       # kumulált (ordinálisnál)
names (f) [f == max (f)]         # MÓDUSZ
round (g [g == max (g)] * 100 , 2)  # leggyakoribb kategória %-a
barplot (f) ; plot (df$tipus)    # oszlopdiagram (plot csak faktorra)

# Mennyiségi változó --------------------------------------------------------------
mean (df$x) ; median (df$x) ; var (df$x) ; sd (df$x) ; IQR (df$x)
quantile (df$x , na.rm = T)
quantile (df$x , probs = seq (0 , 1 , 0.1) , na.rm = T)   # decilisek
psych::describe (df$x)
hist (df$x , breaks = 12 , main = "cím" , xlab = "x" , ylab = "gyakoriság" , col = "lightblue")
boxplot (df$x , horizontal = T)

# Két minőségi változó: kereszttábla ----------------------------------------------
t <- table (df$a , df$b)
round (prop.table (t , margin = 1) , 2)    # soronként %
round (prop.table (t , margin = 2) , 2)    # oszloponként %
addmargins (t)
barplot (t) ; mosaicplot (t)

# Két mennyiségi változó ----------------------------------------------------------
cor (df$x , df$y , use = "pairwise.complete.obs")   # Pearson r
cov (df$x , df$y , use = "pairwise.complete.obs")
plot (df$x , df$y)
abline (lm (df$y ~ df$x))
library (ggplot2)
ggplot (data = df , mapping = aes (x = x , y = y)) +
  geom_point (alpha = 0.3 , position = "jitter") +
  geom_smooth (method = "lm" , se = F) +
  theme_classic ()

# Mennyiségi + minőségi változó ---------------------------------------------------
psych::describeBy (df$x , group = df$tipus)
boxplot (df$x ~ df$tipus , varwidth = T)
# relatív szórás (coefV) = sd / mean

# Melyik mutató? --------------------------------------------------------------------
# nominális   -> módusz, gyakoriság, megoszlás (%)   | ábra: oszlopdiagram
# ordinális   -> + medián, kvartilisek, kumulált     | ábra: oszlopdiagram
# mennyiségi  -> átlag, szórás, kvartilisek          | ábra: hisztogram, boxplot
# r értelmezése: előjel = irány, |r| < 0.3 gyenge, 0.3-0.7 közepes, > 0.7 erős
