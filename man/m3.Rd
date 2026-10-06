\name{m3}
\alias{m3}
\title{m3: 2. óra: vektor, mátrix, data.frame, faktor, szűrés (birthwt)}
\description{
getwd/setwd, names, paste, order, logikai indexelés, matrix, rowMeans, factor, table, prop.table, addmargins, cumsum, feliratozott barplot, szűrés & és | feltételekkel.

A teljes kód lent, az \strong{Examples} részben van.
Konzolba kiírás: \code{kod("m3")}. Vissza a tartalomjegyzékhez: \code{\link{segits}}.
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

search ()
getwd ()
setwd ("S:/2026 R")  # \\ helyett /

#install.packages("ISLR")
library (ISLR)
?Auto



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


# vektorok ----------------------------------------------------------------

# homogén, egydimenziós

nevek <- c ("J" , "É" , "Cs")
names (nevek) <- paste ("naplopok" , 
                        1:3 , 
                        sep = "")
rev (nevek)
?paste

kszamok <- c (32, 7 ,3)
order (kszamok)

kszamok [1]
kszamok [ c(1 , 3) ]
kszamok [ -2 ]
kszamok [ ]
kszamok [1 : 3]

kszamok [c(T , F , F)]
kszamok [kszamok >= 10]
kszamok >= 10

nevek [2]
nevek ["naplopok2"]

vekt <- c ("1" , 0 , "T")
vekt <- c (1 , 0 , T)
typeof(vekt)

# matrix ------------------------------------------------------------------

# homogen , kétdimenziós
set.seed (123)
x <- rnorm (1000)

m <- matrix (data = x , nrow = 100 , byrow = T)
dim (m)
ncol (m)

m []
m [1 , ]
m [ , 2:3 ]
m [ , c(2 , 3) ]
m [100 , 10]

mean (m [1 ,])
rowMeans(m)
colMeans(m)


# dataframe ---------------------------------------------------------------

# heterogén , kétdimenziós

data (birthwt , package = "MASS")
??birthwt

head (birthwt)
summary (birthwt)

birthwt$rassz <- factor (birthwt$race ,
                        levels = 1:3 ,
                        labels = c ("fehér" , "fekete" , "egyéb"))
birthwt$dohanyzo <- factor (birthwt$smoke ,
                            levels = c (0 , 1),
                            labels = c("nemdoh" , "doh"))

unique (birthwt$rassz)
gyaktbla <- table (birthwt$rassz)
table (birthwt$rassz , birthwt$dohanyzo)

prop.table (table (birthwt$rassz , birthwt$dohanyzo) , 
            margin = 1)
addmargins (table (birthwt$rassz , birthwt$dohanyzo))

cumsum (table (birthwt$rassz)) # kummulálás

gyaktbla <- table (birthwt$rassz)
bp <- barplot (table (birthwt$rassz) ,
              main = "oszlopdiagram" ,
              ylab = "gyak [fo]" , 
              ylim = c(0 ,110))
gyaktbla
text (x = bp,
      y = gyaktbla,
      labels = gyaktbla , 
      pos = 3)



dohanyzo_df <- birthwt [ birthwt$smoke == 1 ,  ]

birthwt$smoke == 1
unique (dohanyzo_df$smoke)

birthwt [birthwt$smoke == 1 & birthwt$low == 1 ,  ]
birthwt [birthwt$smoke == 1 | birthwt$low == 1 ,  ]
birthwt [birthwt$smoke == 1 | birthwt$low == 1 ,  c("smoke" , "bwt")]


# (birthwt$smoke == 1) + (birthwt$low == 1)
}
}
