## install.packages("leaflet", repos = "http://cran.us.r-project.org")

library("leaflet")

m <- leaflet()

m <- addTiles(m)

## hmm - VB!
m <- addCircleMarkers(m, lng = -118.28727, lat = 34.02253, label = "Fountain 1", radius = 3, fillOpacity = 1.0, fill = TRUE, fillColor = "red")
m <- addCircleMarkers(m, lng = -118.28520, lat = 34.02020, label = "Fountain 2", radius = 3, fillOpacity = 1.0, fill = TRUE, fillColor = "red")
m <- addCircleMarkers(m, lng = -118.28455, lat = 34.02056, label = "Fountain 3", radius = 3, fillOpacity = 1.0, fill = TRUE, fillColor = "red")
m <- addCircleMarkers(m, lng = -118.28322, lat = 34.01971, label = "Fountain 4", radius = 3, fillOpacity = 1.0, fill = TRUE, fillColor = "red")
m <- addCircleMarkers(m, lng = -118.28324, lat = 34.02223, label = "Fountain 5", radius = 3, fillOpacity = 1.0, fill = TRUE, fillColor = "red")
m <- addCircleMarkers(m, lng = -118.29060, lat = 34.02022, label = "Fountain 6", radius = 3, fillOpacity = 1.0, fill = TRUE, fillColor = "red")
m <- addCircleMarkers(m, lng = -118.28277, lat = 34.02176, label = "Library 1", radius = 3, fillOpacity = 1.0, fill = TRUE, fillColor = "red")
m <- addCircleMarkers(m, lng = -118.28370, lat = 34.02018, label = "Library 2", radius = 3, fillOpacity = 1.0, fill = TRUE, fillColor = "red")
m <- addCircleMarkers(m, lng = -118.28389, lat = 34.02120, label = "Library 3", radius = 3, fillOpacity = 1.0, fill = TRUE, fillColor = "red")
m <- addCircleMarkers(m, lng = -118.28660, lat = 34.01871, label = "Library 4", radius = 3, fillOpacity = 1.0, fill = TRUE, fillColor = "red")
m <- addCircleMarkers(m, lng = -118.28802, lat = 34.01919, label = "Library 5", radius = 3, fillOpacity = 1.0, fill = TRUE, fillColor = "red")
m <- addCircleMarkers(m, lng = -118.28880, lat = 34.01964, label = "Library 6", radius = 3, fillOpacity = 1.0, fill = TRUE, fillColor = "red")
m <- addCircleMarkers(m, lng = -118.29346, lat = 34.01548, label = "My Home", radius = 3, fillOpacity = 1.0, fill = TRUE, fillColor = "red")

m
