# Project-EarthQuake
 
- This project uses an API from USGS - https://earthquake.usgs.gov/earthquakes/feed/v1.0/geojson.php

# Highlights

- Designed as an iOS Universal Application, it supports both iPhone and iPad also Portait and Landscape orientations
- Uses Master and Detail View to show the list and webpage in the detail view of the application
- Uses min deployement target as 12.1 -> XCode 12.4
- Uses Swift 5.x as Programming Language for this exercise
- Uses storyboard and 2 view controllers, masterviewcontroller is embedede inside a navigation controller.
- Uses Swift Packages Manager which holds some of the local packages I created to support the product
- Uses Caching Mechanism to make sure data last fetched data is loaded in the cache when user is offline
       1. Primary and Secondary caching mechanish is used > NSCache and FileManager
       2. Caching is done on the view model layer if there is no data received from the service 
       3. Caching files are exported in local cache manager - CachingPackage, There is a wrapper over the cachingPackage library to be used in the application
- Detail view shows Offline icon when network is offline and webpage fails to load
- Project uses MVVM archiecture
- Data Source in the MasterViewController which uses a tablewview has been made reusable and generic
- Designed RestServicePakcage as a SPM which holds generic networking call which can be reused in other applications as well. Configuration can be customized using operations and we are using EQServiceOperation in this project to show the usage.
- Designed a theme engine which can be used to host any UI configurations
- Uses codable protocol to parse the keys from the JSON
- Added some screenshot in the repository to show iPad and iPhone views

# Code Improvements

- Better on error handling and showing error in the UI
- Code comments
- Analytics
- Unit testing
- UI testing


