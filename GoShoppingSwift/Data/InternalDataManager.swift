//
//  PrivateDataManager.swift
//  GoShoppingSwift
//
//  Created by Ryan Brear on 2019/04/19.
//  Copyright © 2019 Ryan Brear. All rights reserved.
//

import Foundation

/// This struct handles the creation of city, mall, and shop types, and also handles the updating of the data cache
internal struct InternalDataManager {
    
    // MARK: Data management methods
    
    /// Method updates the data cache using info from the server
    /// - parameter data: a dictionary of type [String:Any]
    internal func updateDataCache(from data: [String:Any]) {
        // begin by clearing out old data
        clearOutOldData()
        let cities = data["cities"] as! [[String:Any]]
        for city in cities {
            let cityId = city["id"] as! Int
            let mallsInCity = city["malls"] as! [[String:Any]]
            for mall in mallsInCity {
                let mallId = mall["id"] as! Int
                let shopsInMall = mall["shops"] as! [[String:Any]]
                for shop in shopsInMall {
                    let newShop = createAShop(from: shop, cityId: cityId, mallId: mallId)
                    DataCache.allShops.append(newShop)
                }
                let newMall = createAMall(from: mall, cityId: cityId)
                DataCache.allMalls.append(newMall)
            }
            let newCity = createACity(from: city)
            DataCache.allCities.append(newCity)
        }
    }
    
    
    /// Method clears out the data cache.
    private func clearOutOldData() {
        DataCache.allCities.removeAll()
        DataCache.allMalls.removeAll()
        DataCache.allShops.removeAll()
    }
    
    
    /// Method creates an object of type City
    /// - parameter cityData: the dictionary containing the city info.
    /// - returns: City object
    private func createACity(from cityData: [String:Any]) -> City {
        let id = cityData["id"] as! Int
        let name = cityData["name"] as! String
        let malls = cityData["malls"] as! [[String:Any]]
        var arrayOfMallIdsInCity: [Int] = []
        for mall in malls {
            let mallId = mall["id"] as! Int
            arrayOfMallIdsInCity.append(mallId)
        }
        return City(id: id, name: name, malls: arrayOfMallIdsInCity)
    }
    
    
    /// Method creates an object of type Mall
    /// - parameter mallData: the dictionary containing the mall info.
    /// - parameter cityId: the id of the city in which the mall is found.
    /// - returns: Mall object
    private func createAMall(from mallData: [String:Any], cityId: Int) -> Mall {
        let id = mallData["id"] as! Int
        let name = mallData["name"] as! String
        let shops = mallData["shops"] as! [[String:Any]]
        var arrayOfShopsIdsInMall: [Int] = []
        for shop in shops {
            let shopId = shop["id"] as! Int
            arrayOfShopsIdsInMall.append(shopId)
        }
        return Mall(id: id, name: name, cityId: cityId, shops: arrayOfShopsIdsInMall)
    }
    
    
    /// Method creates an object of type Shop
    /// - parameter shopData: the dictionary containing the shop info.
    /// - parameter mallId: the id of the mall in which the shop is found.
    /// - parameter cityId: the id of the city in which the shop is found.
    /// - returns: Shop object
    private func createAShop(from shopData: [String:Any], cityId: Int, mallId: Int) -> Shop {
        let id = shopData["id"] as! Int
        let name = shopData["name"] as! String
        return Shop(id: id, name: name, mallId: mallId, cityId: cityId)
    }
    
    
    /// Method persists JSON data for offline use.
    internal func saveDataForOfflineUse(data: Data) {
        UserDefaults.standard.set(data, forKey: "jsonData")
    }
    
    
    /// Method retries saved JSON data from UserDefaults, and serialises it at the same time.
    /// - returns: optional dictionary
    internal func retrieveSavedData() -> [String: Any]? {
        if let savedData = UserDefaults.standard.object(forKey: "jsonData") as? Data {
            do {
                // serialise the data
                let serializedData = try JSONSerialization.jsonObject(with: savedData, options: []) as! [String:Any]
                return serializedData
            } catch  {
                return nil
            }
        }
        return nil
    }

}
