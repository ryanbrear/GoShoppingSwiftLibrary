//
//  DataCache.swift
//  GoShoppingSwift
//
//  Created by Ryan Brear on 2019/04/18.
//  Copyright © 2019 Ryan Brear. All rights reserved.
//

import Foundation

/// A cache that stores the most recently fetched city, mall, and shop info.
/// - note: this cache does not persist between app launches.
internal struct DataCache {
    static var allCities = [City]()
    static var allMalls = [Mall]()
    static var allShops = [Shop]()
}
