library(geosphere)
library(tidyr)
library(dplyr)

# house
house <- read.csv("part10(with latlong).csv", header=F, sep=",",stringsAsFactors=F, fileEncoding ="UTF-8")
#house <- separate(house, col=V4, into = c("lat", "lon"), sep=",")
#house <- house[,c(1,2,3,5,4)]
house <- house[,-1:-2]

# incinerator
inci <- read.csv("Incinerator.csv", fileEncoding ="UTF-8")
inci <- separate(inci, col=Lan..Long, into = c("lat", "lon"), sep = ",") # split Lat Lon
inci <- inci[,c(1,3,2)] # change order to lon, lat

# hospital
hos <- read.csv("Hospital.csv", fileEncoding ="UTF-8")
hos <- separate(hos, col=LanLong, into = c("lat", "lon"), sep = ",") # split Lat Lon
hos <- hos[,c(1,3,2)] # change order to lon, lat

# MRT
mrt <- read.csv("MRT.csv", fileEncoding ="UTF-8")
mrt <- separate(mrt, col=Lan..Long, into = c("lat", "lon"), sep = ",") # split Lat Lon
mrt <- mrt[,c(1,3,2)] # change order to lon, lat

# mart
mart <- read.csv("Mart.csv", fileEncoding ="UTF-8")
mart <- separate(mart, col=Lan..Long, into = c("lat", "lon"), sep = ",") # split Lat Lon
mart <- mart[,c(1,3,2)] # change order to lon, lat

# gas
gas <- read.csv("GasStation.csv", fileEncoding ="UTF-8")
gas <- separate(gas, col=Lan..Long, into = c("lat", "lon"), sep = ",") # split Lat Lon
gas <- gas[,c(1,3,2)] # change order to lon, lat

#school
school <- read.csv("School.csv", header=F,sep=",",stringsAsFactors=F,fileEncoding ="UTF-8")
school <- school[-1,]

#park
park <- read.csv("Park.csv", sep=",",stringsAsFactors=F, fileEncoding ="big5")
park <- separate(park, col=Lan..Long, into = c("lat", "lon"), sep = ",") # split Lat Lon
park <- park[,c(1,3,2)] # change order to lon, lat

#get minInci
minInci <- function(x) {
  for (j in 1:nrow(inci)){
    distance <- distGeo(x, inci[j,2:3])/1000
    dis <- c()
    dis <- c(dis, distance)
  }
  min <- min(dis, na.rm = FALSE)
  rm(dis)
  return(min)
}

#get minhos
minHos <- function(x) {
  for (j in 1:nrow(hos)){
    distance <- distGeo(x, hos[j,2:3])/1000
    dis <- c()
    dis <- c(dis, distance)
  }
  min <- min(dis, na.rm = FALSE)
  rm(dis)
  return(min)
}

#get minMRT
minMrt <- function(x) {
  for (j in 1:nrow(mrt)){
    distance <- distGeo(x, mrt[j,2:3])/1000
    dis <- c()
    dis <- c(dis, distance)
  }
  min <- min(dis, na.rm = FALSE)
  rm(dis)
  return(min)
}

#get minMart
minMart <- function(x) {
  for (j in 1:nrow(mart)){
    distance <- distGeo(x, mart[j,2:3])/1000
    dis <- c()
    dis <- c(dis, distance)
  }
  min <- min(dis, na.rm = FALSE)
  rm(dis)
  return(min)
}

#get minGas
minGas <- function(x) {
  for (j in 1:nrow(gas)){
    distance <- distGeo(x, gas[j,2:3])/1000
    dis <- c()
    dis <- c(dis, distance)
  }
  min <- min(dis, na.rm = FALSE)
  rm(dis)
  return(min)
}

#get minSchool
minSchool <- function(x) {
  for (j in 1:nrow(school)){
    distance <- distGeo(x, school[j,2:3])/1000
    dis <- c()
    dis <- c(dis, distance)
  }
  min <- min(dis, na.rm = FALSE)
  rm(dis)
  return(min)
}

#get minPark
minPark <- function(x) {
  for (j in 1:nrow(park)){
    distance <- distGeo(x, park[j,2:3])/1000
    dis <- c()
    dis <- c(dis, distance)
  }
  min <- min(dis, na.rm = FALSE)
  rm(dis)
  return(min)
}

start_time <- Sys.time()

tmp_inci <- apply(house, 1, minInci)
tmp_hos <- apply(house, 1, minHos)
tmp_mrt <- apply(house, 1, minMrt)
tmp_mart <- apply(house, 1, minMart)
tmp_gas <- apply(house, 1, minGas)
tmp_school <- apply(house, 1, minSchool)
tmp_park <- apply(house, 1, minPark)

end_time <- Sys.time()
duration <- end_time - start_time

min_inci <- data.frame(tmp_inci)
min_hos <- data.frame(tmp_hos)
min_mrt <- data.frame(tmp_mrt)
min_mart <- data.frame(tmp_mart)
min_gas <- data.frame(tmp_gas)
min_school <- data.frame(tmp_school)
min_park <- data.frame(tmp_park)

min_all <- bind_cols(list(min_inci,min_hos,min_mrt,min_mart,min_gas,min_school,min_park))

min_partX <- cbind(house,min_all)
write.csv(min_partX, "min_partX.csv")
