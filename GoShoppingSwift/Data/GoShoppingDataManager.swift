//
//  ShoppingData.swift
//  GoShoppingSwift
//
//  Created by Ryan Brear on 2019/04/17.
//  Copyright © 2019 Ryan Brear. All rights reserved.
//

import Foundation

/// Contains all the public methods that give access to the city, mall and shop data.
public struct GoShoppingDataManager {
    
    public init() {}
    
    // MARK: Public access data methods.
    
    /**
     Call this method to update the cache of cities, malls, and shops.
     - parameter success: a callback that takes a Bool.
     */
    public func getLatestData(success:@escaping (Bool)->Void) {
        let endPoint = APIProperties().endPoint
        APIManager().apiGet(endPoint, callBackFunc: { result in
            switch result {
            case .success(let data):
                if let data = data {
                    PrivateDataManager().updateDataCache(from: data)
                    success(true)
                } else {
                    success(false)
                }
            default:
                success(false)
            }
        })
    }
    
    
    /// request a list of cities
    /// - returns: an array of City
    /// - note: if there was an error updating the data cache this array can be empty.
    public func allCities() -> [City] {
        return DataCache.allCities
    }
    
    
    /// request a particular city
    /// - parameter id: the id of the city you need
    /// - returns: nil if id not valid, or an object of type optional City
    public func cityWith(_ id: Int) -> City? {
        var cityToReturn: City?
        for city in DataCache.allCities {
            if city.id == id {
                cityToReturn = city
            }
        }
        return cityToReturn
    }
    
    
    /// request all malls in a city
    /// - parameter city: an object of type City
    /// - returns: all malls in a city.
    /// - note: can be an empty array if there was an error fetching data.
    public func allMallsIn(_ city: City) -> [Mall] {
        let mallIds = city.malls
        var mallsInCity: [Mall] = []
        for id in mallIds {
            if let mall = mallWith(id) {
                mallsInCity.append(mall)
            }
        }
        return mallsInCity
    }
    
    
    /// request a particular mall in a city
    /// - parameter id: the id of the Mall you need.
    /// - returns: nil if id not valid, or an object of type optional Mall
    public func mallWith(_ id: Int) -> Mall? {
        var mallToReturn: Mall?
        for mall in DataCache.allMalls {
            if mall.id == id {
                mallToReturn = mall
            }
        }
        return mallToReturn
    }
    
    
    /// request a list of shops in a mall
    /// - parameter mall: an object of type Mall
    /// - returns: all shops in a mall.
    /// - note: can be an empty array if there was an error fetching data.
    public func allShopsIn(_ mall: Mall) -> [Shop] {
        let shopIds = mall.shops
        var shopsInMall: [Shop] = []
        for id in shopIds {
            if let shop = shopWith(id) {
                shopsInMall.append(shop)
            }
        }
        return shopsInMall
    }
    
    
    /// request a particular shop in a mall
    /// - parameter id: the id of the Shop you need.
    /// - returns: nil if id not valid, or an object of type optional Shop
    public func shopWith(_ id: Int) -> Shop? {
        var shopToReturn: Shop?
        for shop in DataCache.allShops {
            if shop.id == id {
                shopToReturn = shop
            }
        }
        return shopToReturn
    }
    
    
    /// request all the shops in a city
    /// - parameter city: an object of type City
    /// - returns: all shops in a city.
    /// - note: can be an empty array if there was an error fetching data.
    public func allShopsIn(_ city: City) -> [Shop] {
        var allShopsInCity: [Shop] = []
        let allMallsInCity = allMallsIn(city)
        for mall in allMallsInCity {
            allShopsInCity.append(contentsOf: allShopsIn(mall))
        }
        return allShopsInCity
    }
    
}
