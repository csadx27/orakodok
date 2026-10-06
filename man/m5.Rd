\name{m5}
\alias{m5}
\title{m5: gss_cat: az órán feltett kérdések megoldása}
\description{
Fekete demokraták, vallás és rassz, családi állapot korosztályonként, válások rasszonként, jövedelem és tévénézés, jövedelem rasszonként, párt és vallás, életkor és vallás, házasok vs elváltak tévénézése.

A teljes kód lent, az \strong{Examples} részben van.
Konzolba kiírás: \code{kod("m5")}. Vissza a tartalomjegyzékhez: \code{\link{segits}}.
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
# GSS_CAT: AZ ÓRÁN FELTETT KÉRDÉSEK (leíró elemzés) ---------------------------

# Egyelőre CSAK leíró szempontból vizsgálódunk (szignifikancia jövő héttől).
# install.packages ("forcats")   # csak egyszer
data (gss_cat , package = "forcats")
df <- gss_cat

str (df)
dim (df)
colnames (df)
summary (df)


# K1. Hány fekete válaszadó vallja magát demokratának? Arányaiban? -------------

t <- table (df$race , df$partyid)       # 1. a sorban, 2. az oszlopban
t
t ["Black" , ]                          # a feketék pártszimpátiája

# demokrata = "Strong democrat" vagy "Not str democrat"
sum (df$race == "Black" &
     (df$partyid == "Strong democrat" | df$partyid == "Not str democrat"))

# arányaiban: a feketék hány \%-a demokrata?
sum (df$race == "Black" &
     (df$partyid == "Strong democrat" | df$partyid == "Not str democrat")) /
  sum (df$race == "Black")

round (prop.table (t , margin = 1) , 2)  # soronként \%: rasszon belüli megoszlás
# EREDMÉNY: 1992 fekete demokrata, ez a feketék kb. 64\%-a
# (a fehéreknél ugyanez kb. 28\%).


# K2. Hogyan alakul a vallási hovatartozás a különböző etnikai csoportokban? ---
# (K4 ugyanez: rassz és vallás)

# a race-nek van üres szintje ("Not applicable", 0 fő) -> factor() újrafaktorál,
# így eltűnik az üres sor
df$rassz <- factor (df$race)
t <- table (df$rassz , df$relig)
t
round (prop.table (t , margin = 1) , 2)  # rasszonként \%: mert eltérő a csoportméret

barplot (prop.table (table (df$relig , df$rassz) , margin = 2) ,
         main = "Vallás megoszlása rasszonként" , ylab = "arány")
mosaicplot (table (df$rassz , df$relig) , las = 2)
# EREDMÉNY: a fehéreknél (50\%) és a feketéknél a protestáns a leggyakoribb,
# a feketéknél kiugróan (73\%); az "Other" csoportban a katolikus a leggyakoribb (47\%).


# K3. Hogyan alakul a családi állapot a korosztályokban? -----------------------

df$korosztaly <-  factor (cut (x = df$age , breaks = c (0 , 30 , 60 , 200 )) ,
                          labels = c ("fiatal" , "középkorú" , "idős"),
                          ordered = T)
t <- table (df$korosztaly , df$marital)
t
round (prop.table (t , margin = 1) , 2)  # korosztályonként \%

barplot (prop.table (table (df$marital , df$korosztaly) , margin = 2) ,
         main = "Családi állapot korosztályonként" , ylab = "arány")
mosaicplot (t)
# EREDMÉNY: a fiatalok többsége (kb. 2/3) még nem házasodott,
# a középkorúaknál a házas a leggyakoribb (55\%), az időseknél is a házas (46\%),
# de már 30\%-uk özvegy.


# K5. Eltér-e a válások aránya a különböző rasszok között? ---------------------

t <- table (df$rassz , df$marital)
t
round (prop.table (t , margin = 1) , 2)  # rasszonként \%: nézd a Divorced és Married oszlopot
mosaicplot (t)
# EREDMÉNY: az elváltak aránya hasonló (11-16\%), de a házasok aránya
# a feketéknél jóval alacsonyabb (28\%, fehérek: 51\%), a soha nem házasodottaké magasabb (42\%).


# K6. Milyen a kapcsolat a jövedelem és a tévénézés között? --------------------

# a rincome ordinális, és vannak "nem igazi" kategóriái -> ezeket kiszűrjük
df_jov <- df [df$rincome != "No answer" & df$rincome != "Don't know" &
              df$rincome != "Refused"   & df$rincome != "Not applicable" , ]
df_jov$jovedelem <- factor (df_jov$rincome)   # üres szintek eldobása

psych::describeBy (df_jov$tvhours , group = df_jov$jovedelem)
boxplot (df_jov$tvhours ~ df_jov$jovedelem , varwidth = T , las = 2 ,
         xlab = "" , ylab = "napi tévénézés [óra]")
# Pearson-korreláció nem jó, mert a jövedelem ordinális (kategóriák).
# EREDMÉNY: a legmagasabb jövedelmi kategória ($25000 felett) tévézik a
# legkevesebbet (átlag 2,2 óra), a legalacsonyabbakban kb. 3-3,4 óra.
# Gyenge, negatív irányú kapcsolat: nagyobb jövedelem -> kevesebb tévé.


# K7. Eltér-e a jövedelem a különböző rasszok között? --------------------------

t <- table (df_jov$rassz , df_jov$jovedelem)
t
round (prop.table (t , margin = 1) , 2)   # rasszonként \%
barplot (prop.table (table (df_jov$jovedelem , df_jov$rassz) , margin = 2) ,
         main = "Jövedelem megoszlása rasszonként" , ylab = "arány")
# EREDMÉNY: a $25000 feletti kategóriába a fehérek kb. 59\%-a,
# a feketék kb. 47\%-a tartozik.


# K8. Hogyan alakul a politikai beállítottság a vallási csoportokban? ----------

df$vallas <- as.character (df$relig)
df$fo_vallasok <- ifelse (df$vallas == "Protestant" | df$vallas == "Catholic" ,
                          df$vallas ,
                          "egyéb")
t <- table (df$fo_vallasok , df$partyid)
t
round (prop.table (t , margin = 1) , 2)   # vallási csoportonként \%
mosaicplot (t , las = 2)
# EREDMÉNY: a protestánsok között a legtöbb az erős republikánus (15\%),
# az "egyéb" csoportban (ide tartoznak a vallás nélküliek) a független a leggyakoribb (25\%).


# K9. Eltér-e az életkor a különböző vallási csoportok között? -----------------

psych::describeBy (df$age , group = df$fo_vallasok)
boxplot (df$age ~ df$fo_vallasok , varwidth = T)
# EREDMÉNY: a protestánsok a legidősebbek (átlag 49,9 év, medián 49),
# a katolikusok átlaga 46,9, az "egyéb" csoport a legfiatalabb (átlag 42,1, medián 39).


# K10. Kik tévéznek többet: a házasok vagy az elváltak? ------------------------

df_hazas_elvalt <- df [df$marital == "Married" | df$marital == "Divorced" , ]
df_hazas_elvalt$csaladi <- factor (df_hazas_elvalt$marital)   # üres szintek el

psych::describeBy (df_hazas_elvalt$tvhours , group = df_hazas_elvalt$csaladi)
boxplot (df_hazas_elvalt$tvhours ~ df_hazas_elvalt$csaladi , varwidth = T ,
         ylab = "napi tévénézés [óra]")
# EREDMÉNY: az elváltak tévéznek többet (átlag 3,09 vs 2,65 óra),
# a medián mindkét csoportban 2 óra.
}
}
