//
//  Enums.swift
//  GoShoppingSwift
//
//  Created by Ryan Brear on 2019/04/17.
//  Copyright © 2019 Ryan Brear. All rights reserved.
//

import Foundation

/// Enum containing api results
/// - note: '.success' takes an associated value that is a dictionary, allowing you to pass back data in the result.
internal enum ResultOfApiCall {
    case noInternetConnection
    case noDataReturned
    case someErrorOccurred
    case success(Data)
}

