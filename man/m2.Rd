\name{m2}
\alias{m2}
\title{m2: 1. óra (változat): R-alapok, ábrák, adattípusok, indexelés}
\description{
IQR, summary, feliratozott hisztogram, csoportos boxplot, regressziós egyenes, as.* konverziók, vektorok és data.frame indexelése.

A teljes kód lent, az \strong{Examples} részben van.
Konzolba kiírás: \code{kod("m2")}. Vissza a tartalomjegyzékhez: \code{\link{segits}}.
}

\section{Többi oldal}{
\link{segits} | \link{m1} | \link{m2} | \link{m3} | \link{m4} | \link{m5} | \link{m6} | \link{m7} | \link{m8} | \link{m9} | \link{m10}
}
\examples{
\dontrun{
# ÁLTALÁNOS INFO ----------------------------------------------------------

koszones <- "szia"
koszones <- "hi"
koszones <- 3.14
koszones

# komment jele
# ctrl + shift + c - több sorra

#install.packages ("ISLR")
library (ISLR)
?ISLR::Auto

# ctrl + Enter    : sort futtatok
# ctrl + l törlöm a konzolt
# alt -   : <-

# FELTÁRÓ ELEMZÉS ---------------------------------------------------------


data (Auto)
?Auto

dim (Auto)
nrow (Auto)
ncol (Auto)

str (Auto)
head (Auto , n=3)

mean (Auto$horsepower)
median (Auto$horsepower)
IQR (Auto$horsepower)
# sd
# var
# min
# max
# range

summary (Auto$horsepower)

psych::describe (Auto$horsepower)
?psych::describe

# ábrák -------------------------------------------------------------------

### egyváltozós eloszlások ####
hist (Auto$horsepower, 
      breaks = 12, 
      main = "Lóerő eloszlása", 
      xlab = "LE",
      ylab = "gyakoriság",
      col = "lightblue")

boxplot (Auto$horsepower, horizontal = T) 

### kétváltozós eloszlások ####

boxplot (Auto$horsepower ~ Auto$cylinders)

plot (Auto$acceleration ~ Auto$horsepower)
mod1 <- lm (Auto$acceleration ~ Auto$horsepower)
summary (mod1)
abline (mod1)

plot (Auto$acceleration ~ Auto$horsepower)
#abline (mod1) # ugyanaz mint:
abline (lm (Auto$acceleration ~ Auto$horsepower))

plot (Auto$acceleration ~ Auto$horsepower)
mod2 <- lm (Auto$acceleration ~ Auto$weight)
abline (mod2) # mást is rátehetünk, csak itt nincs értelme

### többváltozós eloszlások ####

pairs(Auto [ ,1:6])

 
#install.packages("GGally")
GGally::ggpairs (Auto [ ,1:6])


# adattípusok ---------------------------------------------------------------

nev <- "Ajna"
is.vector(nev)
is.character(nev)

szam <- 8
is.numeric (szam)
is.integer (szam)
is.double (szam)

egeszszam <- 8L
is.double (egeszszam)
is.integer (egeszszam)

DC <- TRUE
DC <- T
is.logical (DC)

as.double (egeszszam)
# masikegeszszam <- as.integer (szam)
# is.integer(masikegeszszam)   # :""(

as.logical (nev)
as.logical ("T")
as.logical (1)
as.logical ("TRUE")
as.character (szam)

as.numeric( "10")
as.logical (1)
as.logical (0)

is.integer ("4L")
is.integer (4)

nevek <- c("T" ,"B" ,"L" ,"T" ,"O" ,"H")

nevek []
nevek [1]
nevek [1:2]
nevek [c(1,3)]
nevek [c(1,3,5)]
nevek [1:6]
nevek [5:length (nevek)]
nevek [-3]

nevek == "T"
nevek [nevek == "T"]

names (nevek) <- nevek
nevek ["O"]

#data (Auto)

Auto [ 3 ,   ]
Auto [   , 6 ]
Auto [ 3 , 6 ]
}
}
