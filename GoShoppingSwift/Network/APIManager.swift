//
//  APIManager.swift
//  GoShoppingSwift
//
//  Created by Ryan Brear on 2019/04/17.
//  Copyright © 2019 Ryan Brear. All rights reserved.
//

import Foundation

/// Handles the fetching of data from an end point
internal struct APIManager {
    
    /**
     The method that performs API Gets.
     - parameter endPointUrl: the String used as the end point.
     - parameter callBackFunc: a closure that captures the result of the call using the enum ResultOfApiCall.
     */
    internal func apiGet(_ endPoint: String, callBackFunc: @escaping (ResultOfApiCall) -> Void) {
        
        // create a url with above end point and check it's a valid URL
        guard let url = URL(string: endPoint) else {
            print("Error: cannot create URL")
            callBackFunc(.someErrorOccurred)
            return
        }
        
        // create a mutable url request
        var urlRequest = URLRequest(url: url)
        
        // specify what kind of request you want to perform
        urlRequest.httpMethod = "GET"
        
        // set config
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = [
            "Accept": "application/json",
        ]
        
        // create a session reference
        let session = URLSession(configuration: config)
        
        // create a URL task
        let task = session.dataTask(with: urlRequest, completionHandler:
        { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            // check if internet connection
            if let error = error as NSError? {
                if error.code == -1009 {
                    callBackFunc(.noInternetConnection)
                }
            }
            
            // check we got back some data
            guard data != nil else {
                callBackFunc(.noDataReturned)
                return
            }
            
            // check if success or error in response
            if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode {
                // serialize the data
                do {
                    let serializedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                    callBackFunc(.success(serializedData))
                } catch  {
                    callBackFunc(.someErrorOccurred)
                }
            } else {
                callBackFunc(.someErrorOccurred)
            }
        })
        // Send the task.
        task.resume()
    }
    
}
