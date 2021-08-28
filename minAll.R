library(geosphere)
library(tidyr)
library(dplyr)

# house
house <- read.csv("part11.csv", header=F, sep=",",stringsAsFactors=F, fileEncoding ="UTF-8")
house <- separate(house, col=V4, into = c("lat", "lon"), sep=",")
house <- house[,-1]
house <- house[,c(1,2,4,3)]

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

gas <- read.csv("GasStation.csv", fileEncoding ="UTF-8")
gas <- separate(gas, col=Lan..Long, into = c("lat", "lon"), sep = ",") # split Lat Lon
gas <- gas[,c(1,3,2)] # change order to lon, lat

#school
school <- read.csv("School.csv", header=F,sep=",",stringsAsFactors=F,fileEncoding ="UTF-8")
school <- school[-1,]
school <- separate(school, col=V2, into = c("lat", "lon"), sep = ",") # split Lat Lon
school <- school[,c(1,3,2)] # change order to lon, lat

#park
park <- read.csv("Park.csv", sep=",",stringsAsFactors=F, fileEncoding ="big5")
park <- separate(park, col=Lan..Long, into = c("lat", "lon"), sep = ",") # split Lat Lon
park <- park[,c(1,3,2)] # change order to lon, lat


min_inci <- c()
min_hos <- c()
min_mrt <- c()
min_mart <- c()
min_gas <- c()
min_school <- c()
min_park <- c()

start_time <- Sys.time()

for (i in 1:nrow(house)) {      # incinerator
  for (j in 1:nrow(inci)) {
    distance <- distGeo(house[i,3:4], inci[j,2:3])/1000
    dis <- c()
    dis <- c(dis, distance)
  }
  min <- min(dis, na.rm = FALSE)
  min_inci <- c(min_inci, min)
  rm(dis)
}

for (i in 1:nrow(house)) {       # hospital
  for (j in 1:nrow(hos)) {
    distance <- distGeo(house[i,3:4], hos[j,2:3])/1000
    dis <- c()
    dis <- c(dis, distance)
  }
  min <- min(dis, na.rm = FALSE)
  min_hos <- c(min_hos, min)
  rm(dis)
}

for (i in 1:nrow(house)) {        # mrt
  for (j in 1:nrow(mrt)) {
    distance <- distGeo(house[i,3:4], mrt[j,2:3])/1000
    dis <- c()
    dis <- c(dis, distance)
  }
  min <- min(dis, na.rm = FALSE)
  min_mrt <- c(min_mrt, min)
  rm(dis)
}

for (i in 1:nrow(house)) {         # mart
  for (j in 1:nrow(mart)) {
    distance <- distGeo(house[i,3:4], mart[j,2:3])/1000
    dis <- c()
    dis <- c(dis, distance)
  }
  min <- min(dis, na.rm = FALSE)
  min_mart <- c(min_mart, min)
  rm(dis)
}

for (i in 1:nrow(house)) {         # gas
  for (j in 1:nrow(gas)) {
    distance <- distGeo(house[i,3:4], gas[j,2:3])/1000
    dis <- c()
    dis <- c(dis, distance)
  }
  min <- min(dis, na.rm = FALSE)
  min_gas <- c(min_gas, min)
  rm(dis)
}

for (i in 1:nrow(house)) {     # school
  for (j in 1:nrow(school)) {
    distance <- distGeo(house[i,3:4], school[j,2:3])/1000
    dis <- c()
    dis <- c(dis, distance)
  }
  min <- min(dis, na.rm = FALSE)
  min_school <- c(min_school, min)
  rm(dis)
}


for (i in 1:nrow(house)) {    # park
  for (j in 1:nrow(park)) {
    distance <- distGeo(house[i,3:4], park[j,2:3])/1000
    dis <- c()
    dis <- c(dis, distance)
  }
  min <- min(dis, na.rm = FALSE)
  min_park <- c(min_park, min)
  rm(dis)
}

end_time <- Sys.time()
duration <- end_time - start_time

min_data1 <- data.frame(min_inci)
min_data2 <- data.frame(min_hos)
min_data3 <- data.frame(min_mrt)
min_data4 <- data.frame(min_mart)
min_data5 <- data.frame(min_gas)
min_data6 <- data.frame(min_school)
min_data7 <- data.frame(min_park)

min_all <- bind_cols(list(min_data1,min_data2,min_data3,min_data4,min_data5,min_data6,min_data7))

min_partX <- cbind(house,min_all)
write.csv(min_partX, "min_partX.csv")

min_partX <- read.csv("min_partX.csv", header=FALSE, sep=",",stringsAsFactors=F, fileEncoding ="big5")
colnames(min_part6) <- c("index", "addr", "price", "lon", "lat", "min_mart", "min_inci","min_hos","min_mrt","min_gas", "min_school", "min_park")
write.csv(min_partX, "min_partX.csv")

