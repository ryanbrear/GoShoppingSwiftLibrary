# GoShoppingSwift
An iOS library written in Swift 4.2 as part of the interview process with Entersekt.  The library provides API's to easily pull in city, mall, and shop info into an iOS app. 

![Simulator Screen Shot - iPhone XR - 2019-04-20 at 07 44 43](https://user-images.githubusercontent.com/21098812/56453281-7300cd80-6340-11e9-91c3-2943b21b02e0.png)
![Simulator Screen Shot - iPhone XR - 2019-04-20 at 07 44 47](https://user-images.githubusercontent.com/21098812/56453282-73996400-6340-11e9-9180-9fcd7ab4ac4a.png)

# Features
- Written in Swift 4.2
- Easily pull in info on shopping opportunities in South Africa into your app. 
- Info is grouped by city, mall, and shop.

# Requirements
- iOS 9.0+
- XCode 9.0+

## Installation
- Download the repo and add it to your project as an embedded binary.

## Usage
- To use GoShoppingSwift in a file, begin by importing it
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

- GoShoppingSwift makes three types available to you: City, Mall, Shop
- Request a list of all cities. Returns an array of type City:
```Swift
let allCities = GoShoppingDataManager().allCities()
```

- Request a particular city by pasing in the id of that city.
```Swift
let city = GoShoppingDataManager().cityWithId(10)
let cityName = city.name
```

- Request all malls in a city.:
```Swift
let dataManager = GoShoppingDataManager()
let capeTown = dataManager.cityWithId(10)
let allMallsInCity = dataManager.allMallsIn(capeTown)
```

- Request a particular mall in a city.
```Swift
let mall = GoShoppingDataManager().mallWithId(20)
```

- Request a list of all shops in a mall.
```Swift
let dataManager = GoShoppingDataManager()
let mall = dataManager.getMallWithId(20)
let allShopsInMall = dataManager.allShopsIn(mall)
```

- Request a particular shop in a mall.
```Swift
let shop = GoShoppingDataManager().shopWithId(2)
```

- Request all the shops in a city
```Swift
let dataManager = GoShoppingDataManager()
let city = dataManager.getCityWithId(10)
let allShopsInCity = allShopsIn(city)
```

## Author
Ryan Brear, rpbrear@gmail.com
