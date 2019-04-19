//
//  DataTypes.swift
//  GoShoppingSwift
//
//  Created by Ryan Brear on 2019/04/18.
//  Copyright © 2019 Ryan Brear. All rights reserved.
//

import Foundation


public struct City {
    public var id: Int
    public var name: String
    public var malls: [Int]
    
    init(id: Int, name: String, malls: [Int]) {
        self.id = id
        self.name = name
        self.malls = malls
    }
}


public struct Mall {
    public var id: Int
    public var name: String
    public var cityId: Int
    public var shops: [Int]
    
    init(id: Int, name: String, cityId: Int, shops: [Int]) {
        self.id = id
        self.name = name
        self.cityId = cityId
        self.shops = shops
    }
    
}


public struct Shop {
    public var id: Int
    public var name: String
    public var mallId: Int
    public var cityId: Int
    
    init(id: Int, name: String, mallId: Int, cityId: Int) {
        self.id = id
        self.name = name
        self.mallId = mallId
        self.cityId = cityId
    }
}
