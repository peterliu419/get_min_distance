library(geosphere)
library(tidyr)
library(dplyr)

# house
house <- read.csv("./ready_to_run/part37_ready.csv", header=F, sep=",",stringsAsFactors=F, fileEncoding ="UTF-8")
house_addr <- data.frame(house[,1])
house <- house[,-1]

# incinerator
inci <- read.csv("Inci_final.csv", fileEncoding ="UTF-8")
inci <- inci[,c(1,3,2)] # change order to lon, lat
inci <- inci[,-1]

# hospital
hos <- read.csv("Hospital_final.csv", fileEncoding ="UTF-8")
hos <- separate(hos, col=LanLong, into = c("lat", "lon"), sep = ",") # split Lat Lon
hos <- hos[,c(1,3,2)] # change order to lon, lat
hos <- hos[,-1]

# MRT
mrt <- read.csv("MRT_final.csv", fileEncoding ="UTF-8")
mrt <- mrt[,c(1,3,2)] # change order to lon, lat
mrt <- mrt[,-1]

# mart
mart <- read.csv("Mart_final.csv", fileEncoding ="UTF-8")
mart <- mart[,c(1,3,2)] # change order to lon, lat
mart <- mart[,-1]

# gas
gas <- read.csv("GasStation_final.csv", fileEncoding ="UTF-8")
gas <- gas[,c(1,3,2)] # change order to lon, lat
gas <- gas[,-1]

#school
school <- read.csv("School_final.csv", header=F,sep=",",stringsAsFactors=F,fileEncoding ="UTF-8")
school <- school[-1,]
school <- school[,-1]

#park
park <- read.csv("Park_final.csv", header=F,sep=",",stringsAsFactors=F, fileEncoding ="UTF-8")
park <- separate(park, col=V2, into = c("lat", "lon"), sep = ",") # split Lat Lon
park <- park[,c(1,3,2)] # change order to lon, lat
park <- park[,-1]

# min_inci
system.time(tmp_inci <- apply(house, 1, function(x) {
  dm <- distm(x, inci, fun=distGeo)
  min <- min(dm)
  return(min/1000)
}))

# min_hos
system.time(tmp_hos <- apply(house, 1, function(x) {
  dm <- distm(x, hos, fun=distGeo)
  min <- min(dm)
  return(min/1000)
}))

# min_mrt
system.time(tmp_mrt <- apply(house, 1, function(x) {
  dm <- distm(x, mrt, fun=distGeo)
  min <- min(dm)
  return(min/1000)
}))

# min_mart
system.time(tmp_mart <- apply(house, 1, function(x) {
  dm <- distm(x, mart, fun=distGeo)
  min <- min(dm)
  return(min/1000)
}))

# min_gas
system.time(tmp_gas <- apply(house, 1, function(x) {
  dm <- distm(x, gas, fun=distGeo)
  min <- min(dm)
  return(min/1000)
}))

# min_school
system.time(tmp_school <- apply(house, 1, function(x) {
  dm <- distm(x, school, fun=distGeo)
  min <- min(dm)
  return(min/1000)
}))

# min_park
system.time(tmp_park <- apply(house, 1, function(x) {
  dm <- distm(x, park, fun=distGeo)
  min <- min(dm)
  return(min/1000)
}))


tmp_all <- cbind(tmp_inci,tmp_hos,tmp_mrt,tmp_mart,tmp_gas,tmp_school,tmp_park)
min_all <- data.frame(tmp_all)

# change part 
min_part37 <- cbind(house_addr,min_all)
colnames(min_part37) <- c("addr", "min_inci", "min_hos", "min_mrt", "min_mart", "min_gas", "min_school", "min_park")
write.csv(min_part37, "min_part37.csv")


