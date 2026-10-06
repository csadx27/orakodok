\name{m7}
\alias{m7}
\title{m7: gss_cat: további gyakorló feladatok megoldása}
\description{
Életkor eloszlása, pártszimpátia (sorrend, df_party, factor nmax = 7, medián cumsum-mal), fő vallások és párt, jövedelem évenként, párt évenként, miért rossz a mean(as.numeric(rincome)).

A teljes kód lent, az \strong{Examples} részben van.
Konzolba kiírás: \code{kod("m7")}. Vissza a tartalomjegyzékhez: \code{\link{segits}}.
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
# GSS_CAT: TOVÁBBI GYAKORLÓ FELADATOK ------------------------------------------

# install.packages ("forcats")   # csak egyszer
data (gss_cat , package = "forcats")
df <- gss_cat
str (df)


# G1. Az életkor eloszlása ------------------------------------------------------

# mennyiségi (arány skálájú) változó -> hisztogram, boxplot
psych::describe (df$age)
quantile (df$age , na.rm = T)
IQR (df$age , na.rm = T)
sum (is.na (df$age))

hist (df$age , breaks = 35 , main = "Életkor eloszlása" ,
      xlab = "év" , ylab = "gyakoriság" , col = "lightblue")
boxplot (df$age , horizontal = T)

# VÁLASZ:
# átlag 47,18 év, medián 46 év, szórás 17,29 év, IQR 26 év (Q1 = 33, Q3 = 59),
# min. 18, max. 89, ferdeség 0,37 (enyhén jobbra ferde, közel szimmetrikus).
# Mivel közel szimmetrikus, az átlag és a szórás is jól jellemzi.


# G2. Politikai beállítottság ---------------------------------------------------

f <- table (df$partyid)
f
round (prop.table (f) , 2)
barplot (f , las = 2 , main = "Politikai beállítottság" , ylab = "gyakoriság [fő]")
names (f) [f == max (f)]                  # módusz

# VÁLASZ:
# Van természetes sorrend: Strong republican -> ... -> Independent -> ... -> Strong democrat
# (ordinális). A "No answer", "Don't know", "Other party" viszont nem illik bele
# a sorrendbe. Ábrán a kategóriákat a sorrendjükben kell hagyni (nem gyakoriság szerint).
# Értelmezhető: módusz (Independent, 4119 fő) és - a nem illő kategóriák nélkül - a medián.

# df_party: csak a skálára illő válaszok
df_party <- df [df$partyid != "No answer" & df$partyid != "Don't know" &
                df$partyid != "Other party" , ]
table (df_party$partyid)                  # a 3 kiszűrt kategória 0-val még ott van
df_party$partyid <- factor (df_party$partyid , nmax = 7)
table (df_party$partyid)                  # most már csak 7 szint
# Mi történt? A factor() újrafaktorálta a változót: az üres szintek eltűntek,
# 10 helyett 7 szint maradt (nmax = a szintek maximális száma).

# medián ordinális változónál: ahol a kumulált relatív gyakoriság eléri az 50\%-ot
round (cumsum (prop.table (table (df_party$partyid))) , 2)
# a kumulált arány az "Independent" kategóriánál lépi át a 0,5-öt (0,34 -> 0,54)
# -> medián: Independent

barplot (table (df_party$partyid) , las = 2 , main = "Pártszimpátia (7 kategória)")


# G3. Fő vallási csoportok és politikai beállítottság ---------------------------

df_party$vallas <- as.character (df_party$relig)
df_party$fo_vallasok <- ifelse (df_party$vallas == "Protestant" |
                                df_party$vallas == "Catholic" ,
                                df_party$vallas ,
                                "egyéb")
t <- table (df_party$partyid , df_party$fo_vallasok)
t                                          # darabszámok
round (prop.table (t , margin = 2) , 2)    # vallási csoportonként (oszloponként) \%

barplot (prop.table (t , margin = 2) ,
         main = "Pártszimpátia vallási csoportonként" , ylab = "arány")
mosaicplot (table (df_party$fo_vallasok , df_party$partyid) , las = 2)

# VÁLASZ:
# ARÁNYOKAT érdemes összehasonlítani, mert a csoportok mérete nagyon eltér
# (protestáns kb. kétszer annyi, mint katolikus vagy egyéb).
# A protestánsok közt a legtöbb az erős republikánus (15\%), az "egyéb" csoportban
# a legkevesebb (5\%); ott a független a leggyakoribb (26\%).


# G4. Jövedelem (rincome) az egyes években --------------------------------------

# year: itt a felmérés hullámát jelöli -> csoportosító (minőségi) változóként kezeljük
# rincome: ordinális (jövedelemsávok), de vannak sorrendbe nem illő kategóriák
df_jov <- df [df$rincome != "No answer" & df$rincome != "Don't know" &
              df$rincome != "Refused"   & df$rincome != "Not applicable" , ]
df_jov$jovedelem <- factor (df_jov$rincome)

t <- table (df_jov$year , df_jov$jovedelem)
t
round (prop.table (t , margin = 1) , 2)    # évenként \%, mert eltér az évi mintaméret
barplot (prop.table (table (df_jov$jovedelem , df_jov$year) , margin = 2) ,
         main = "Jövedelemsávok évenként" , ylab = "arány")

# VÁLASZ: ordinális változó -> halmozott (100\%-os) oszlopdiagram, évenkénti megoszlás.
# A "$25000 or more" sáv aránya 2000-ről 2014-re 50\%-ról 62\%-ra nő
# (ebben az infláció is benne van: a sávhatárok nem változnak).


# G5. Pártszimpátia az egyes években --------------------------------------------

table (df$year)                            # eltérő évi mintanagyság!
t <- table (df$year , df$partyid)
round (prop.table (t , margin = 1) , 2)    # SORONKÉNT (évenként) \%
barplot (prop.table (table (df$partyid , df$year) , margin = 2) ,
         main = "Pártszimpátia évenként" , ylab = "arány")

# VÁLASZ:
# Az évi mintaméret eltér (pl. 2006: 4510 fő, 2012: 1974 fő), ezért az évenkénti
# (soronkénti, margin = 1) arányokat kell összehasonlítani, nem a darabszámokat.
# Nincs látványos trend: a független ("Independent") válaszadók aránya 16-22\% között
# ingadozik (2008: 16\%, 2006: 22\%), az erős republikánusoké 9-14\% között.


# G6. Mit csinál: mean (as.numeric (df$rincome) , na.rm = T) ? ------------------

mean (as.numeric (df$rincome) , na.rm = T)
as.numeric (df$rincome) [1:10]             # a faktor szintjeinek SORSZÁMAI
table (as.numeric (df$rincome))

# VÁLASZ:
# Az as.numeric() a faktor szintjeinek sorszámát (1-16) adja vissza, nem a jövedelmet.
# Az eredmény (8,93) ezeknek a kódoknak az átlaga, ami nem értelmezhető, mert:
# - a rincome ordinális: a kódok közti "távolság" nem egyforma (a sávok szélessége eltér),
#   ordinális változónál átlag nem számolható;
# - a "No answer", "Don't know", "Refused", "Not applicable" is kapott sorszámot
#   (1, 2, 3, 16), mintha jövedelem lenne;
# - a kódolás fordított: kisebb sorszám = nagyobb jövedelem.
}
}
