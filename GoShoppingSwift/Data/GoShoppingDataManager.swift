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
    
    public enum UpdateDataResult {
        case success
        case error
        case noInternet
    }
    
    public init() {}
    
    // MARK: Public access data methods
    
     /// Call this method to update the cache of cities, malls, and shops.
     /// - parameter success: a callback that takes a Bool.
    public func getLatestData(updateDataResult:@escaping (UpdateDataResult)->Void) {
        let endPoint = APIProperties().endPoint
        APIManager().apiGet(endPoint, callBackFunc: { result in
            switch result {
            case .success(let data):
                do {
                    // serialise the data and update the cache
                    let serializedData = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                    let dataManager = InternalDataManager()
                    dataManager.updateDataCache(from: serializedData)
                    // persist a copy of the data for offline access
                    dataManager.saveDataForOfflineUse(data: data)
                    updateDataResult(.success)
                } catch  {
                    updateDataResult(.error)
                }
            case .noInternetConnection:
                updateDataResult(.noInternet)
            default:
                updateDataResult(.error)
            }
        })
    }
    
    
    /// Call this method when you are offline and want to update the data cache with the last saved info.
    /// - returns: True if successful, false if there was no previously saved data.
    public func getLastSavedDataForOfflineUse() -> Bool {
        let dataManager = InternalDataManager()
        if let savedData = dataManager.retrieveSavedData() {
            dataManager.updateDataCache(from: savedData)
            return true
        }
        return false
    }
    
    
    /// Request a list of cities
    /// - returns: an array of City
    /// - note: if there was an error updating the data cache this array can be empty.
    public func allCities() -> [City] {
        return DataCache.allCities
    }
    
    
    /// Request a particular city
    /// - parameter id: the id of the city you need
    /// - returns: nil if id not valid, or an object of type optional City
    public func cityWithId(_ id: Int) -> City? {
        var cityToReturn: City?
        for city in DataCache.allCities {
            if city.id == id {
                cityToReturn = city
            }
        }
        return cityToReturn
    }
    
    
    /// Request all malls in a city
    /// - parameter city: an object of type City
    /// - returns: all malls in a city.
    /// - note: can be an empty array if there was an error fetching data.
    public func allMallsIn(_ city: City) -> [Mall] {
        let mallIds = city.malls
        var mallsInCity: [Mall] = []
        for id in mallIds {
            if let mall = mallWithId(id) {
                mallsInCity.append(mall)
            }
        }
        return mallsInCity
    }
    
    
    /// Request a particular mall in a city
    /// - parameter id: the id of the Mall you need.
    /// - returns: nil if id not valid, or an object of type optional Mall
    public func mallWithId(_ id: Int) -> Mall? {
        var mallToReturn: Mall?
        for mall in DataCache.allMalls {
            if mall.id == id {
                mallToReturn = mall
            }
        }
        return mallToReturn
    }
    
    
    /// Request a list of shops in a mall
    /// - parameter mall: an object of type Mall
    /// - returns: all shops in a mall.
    /// - note: can be an empty array if there was an error fetching data.
    public func allShopsIn(_ mall: Mall) -> [Shop] {
        let shopIds = mall.shops
        var shopsInMall: [Shop] = []
        for id in shopIds {
            if let shop = shopWithId(id) {
                shopsInMall.append(shop)
            }
        }
        return shopsInMall
    }
    
    
    /// Request a particular shop in a mall
    /// - parameter id: the id of the Shop you need.
    /// - returns: nil if id not valid, or an object of type optional Shop
    public func shopWithId(_ id: Int) -> Shop? {
        var shopToReturn: Shop?
        for shop in DataCache.allShops {
            if shop.id == id {
                shopToReturn = shop
            }
        }
        return shopToReturn
    }
    
    
    /// Request all the shops in a city
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
