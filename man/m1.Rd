\name{m1}
\alias{m1}
\title{m1: 1. óra: feltáró elemzés az Auto adatbázison}
\description{
dim, str, mean, median, var, sd, quantile, psych::describe; boxplot, hist, plot, lm + abline, pairs, GGally::ggpairs; adattípusok.

A teljes kód lent, az \strong{Examples} részben van.
Konzolba kiírás: \code{kod("m1")}. Vissza a tartalomjegyzékhez: \code{\link{segits}}.
}

\section{Többi oldal}{
\link{segits} | \link{m1} | \link{m2} | \link{m3} | \link{m4} | \link{m5} | \link{m6} | \link{m7} | \link{m8} | \link{m9} | \link{m10}
}
\examples{
\dontrun{
# Általános info ----------------------------------------------------------

# ctrl + shift + r   fejezetcím beszúrás
# ctrl + shift + c   több sor kommentelése
# comment

koszones <- "hi"
koszones

#install.packages("ISLR")
library (ISLR)
?Auto


# Feltáró elemzés ---------------------------------------------------------


data (Auto)
fix(Auto)
str (Auto)

dim (Auto)
nrow (Auto)
ncol (Auto)

mean (Auto$mpg)
median (Auto$mpg)
var (Auto$mpg)
sd (Auto$mpg)
min
max

quantile(Auto$mpg , probs = 0.1)
quantile(Auto$mpg , probs = 0.9)

dec <- seq (0 , 1 , 0.01)

quantile(Auto$mpg , probs = dec)

ISLR::Auto

psych::describe(Auto$mpg)
?psych::describe()


# ábrák -------------------------------------------------------------------

# ALT + SHIFT + FEL/LE  : másolja a sort
boxplot (Auto$mpg , horizontal = T)
boxplot (Auto$acceleration , horizontal = T)
Auto$mpg

hist (Auto$mpg , breaks = 6,
      col = "lightblue",
      main = "Fogyasztás eloszlása",
      xlab = "mpg",
      ylab = "gyakoriság")

plot (y = Auto$horsepower,
      x = Auto$mpg)

plot (Auto$mpg ~ Auto$horsepower)
mod1 <- lm (Auto$mpg ~ Auto$horsepower)
lm (formula =  mpg ~ . - name , data = Auto)
abline (mod1)

summary (mod1)

cov (Auto [ , 1:6])

pairs(Auto [ , 1:6])

GGally::ggpairs(Auto [ , 1:6])

# adattípusok -------------------------------------------------------------

nev <- "AJNA"
is.character(nev)
is.vector(nev)

DC <- TRUE
is.logical (DC)

szam <- 8
is.numeric (szam)
is.integer (szam)
is.double (szam)

egesz <- as.integer (szam)

szam <- 8L

as.character (szam)
as.character (DC)
as.numeric (DC)

as.logical (0)
as.numeric ("egy")
as.numeric ("1")
as.numeric (as.logical("FALSE"))
}
}
