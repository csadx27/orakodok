\name{kod}
\alias{kod}
\title{Órai kód kiírása a konzolba}
\description{Kiírja a konzolba a kiválasztott téma teljes R-kódját (m1, m2, ...).}
\usage{kod(tema = NULL)}
\arguments{
\item{tema}{a téma neve, pl. \code{"m1"}; ha üres, kiírja a témák listáját.}
}
\value{A script sorai (láthatatlanul).}
\seealso{\code{\link{segits}}}
\examples{
kod()
kod("m9")
}
