\name{EOF}
\alias{EOF}
\title{ Compute spatial or temporal empirical orthogonal function (EOF) }
\description{ Compute spatial or temporal empirical orthogonal function (EOF) }
\usage{ 
EOF(x, how = c("spatial", "temporal"), returnPredictions = TRUE, ...)
}
\arguments{
\item{x}{ object of class \code{STFDF}}
\item{how}{ character; choose \code{"spatial"} or \code{"temporal"} mode }
\item{returnPredictions}{ logical; if TRUE, the functions are returned (i.e.,
predicted principle components, or PC scores); if FALSE, the object returned
by \link{prcomp} is returned, which can be printed, or from which a
summary can be computed; see examples. }
\item{...}{ arguments passed on to function \link{prcomp}; note that
\code{scale.=TRUE} needs to be specified to obtain EOFs based 
on correlation (default: covariance) }
}
\value{
In spatial mode, the appropriate \code{Spatial*} object. In temporal
mode, an object of class \code{xts}.
}
\examples{

if (require(gstat)) {
data(wind)
library(sp)
wind.loc$y = as.numeric(char2dms(as.character(wind.loc[["Latitude"]])))
wind.loc$x = as.numeric(char2dms(as.character(wind.loc[["Longitude"]])))
coordinates(wind.loc) = ~x+y
proj4string(wind.loc) = "+proj=longlat +datum=WGS84"

# match station order to names in wide table:
stations = 4:15
wind.loc = wind.loc[match(names(wind[stations]), wind.loc$Code),]
row.names(wind.loc) = wind.loc$Station
wind$time = ISOdate(wind$year+1900, wind$month, wind$day, 0)
space = list(values = names(wind)[stations])
wind.st = stConstruct(wind[stations], space, wind$time, SpatialObj = wind.loc)
# select firt 500 time steps, to limit run time:
wind.st = wind.st[,1:500]
wind.eof.1 = EOF(wind.st)
wind.eof.2 = EOF(wind.st, "temporal")
wind.eof.1.PCs = EOF(wind.st, returnPredictions=FALSE)
EOF(wind.st, "temporal", returnPredictions=FALSE)
summary(EOF(wind.st, returnPredictions=FALSE))
summary(EOF(wind.st, "temporal", returnPredictions=FALSE))
plot(EOF(wind.st, "temporal", returnPredictions=FALSE))
}
}
\keyword{manip}
