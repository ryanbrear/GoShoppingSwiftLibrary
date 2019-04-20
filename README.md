# GoShoppingSwift
An iOS library written in Swift 4.2 as part of the interview process with Entersekt. The library provides an easy way to pull in city, mall, and shop info into an iOS app. 

![Simulator Screen Shot - iPhone XR - 2019-04-20 at 07 44 43](https://user-images.githubusercontent.com/21098812/56454005-d42d9e80-634a-11e9-921a-0e9b2434d692.png)![Simulator Screen Shot - iPhone XR - 2019-04-20 at 07 44 47](https://user-images.githubusercontent.com/21098812/56454006-d42d9e80-634a-11e9-9cf6-7f961ef18ae4.png)

# Features
- Written in Swift 4.2
- Easily pull in info on shopping opportunities in South Africa into your app. 
- Info is grouped by city, mall, and shop.

# Requirements
- iOS 9.0+
- XCode 9.0+

# Installation
- Download the repo and add it to your project as an embedded binary.

# Demo
- Here is a link to a demo app utilising the library:
https://github.com/ryanbrear/GoShopping_App

# Usage
- To use GoShoppingSwift in a file, begin by importing it.
```Swift
import GoShoppingSwift
```


- To fetch the latest shopping info:
```Swift
GoShoppingDataManager().getLatestData { success in
  if success {
    // use API methods to access updated info here 
  } else {
    // handle failure here
}
```


- GoShoppingSwift makes three types available to you: `City`, `Mall`, `Shop`
- Request a list of all cities. Returns an array of type `City`:
```Swift
let allCities = GoShoppingDataManager().allCities()
```


- Request a particular city by pasing in the id of that city:
```Swift
let city = GoShoppingDataManager().cityWithId(10)
let cityName = city.name
```


- Request all malls in a city:
```Swift
// 1st approach
let dataManager = GoShoppingDataManager()
let capeTown = dataManager.cityWithId(10)
var allMallsInCity = dataManager.allMallsIn(capeTown)
// 2nd approach
allMallsInCity = capeTown.allMallsInCity()
```



- Request a particular mall in a city:
```Swift
let mall = GoShoppingDataManager().mallWithId(20)
```


- Request a list of all shops in a mall:
```Swift
// 1st approach
let dataManager = GoShoppingDataManager()
let mall = dataManager.getMallWithId(20)
var allShopsInMall = dataManager.allShopsIn(mall)
// 2nd approach
allShopsInMall = mall.allShopsInMall()
```


- Request a particular shop in a mall:
```Swift
let shop = GoShoppingDataManager().shopWithId(2)
```


- Request all the shops in a city:
```Swift
// 1st approach
let dataManager = GoShoppingDataManager()
let city = dataManager.getCityWithId(10)
var allShopsInCity = allShopsIn(city)
// 2nd approach
allShopsInCity = city.allShopsInCity()
```

# Author
Ryan Brear, rpbrear@gmail.com
