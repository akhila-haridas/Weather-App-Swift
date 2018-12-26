//
//  APIClient.swift
//  WeatherApp
//
//  Created by goodbox on 21/12/18.
//  Copyright © 2018 goodbox. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {
    static let sharedInstance = APIClient()
    
    func fetchDictionaryDataWithGetRequest(requestUrl: String, parameters: [String: AnyObject], headers: [String: String], onCompletion: @escaping (NSError?,[String: AnyObject]?)-> Void) -> Void {
        print(parameters)
        print(requestUrl)
        print(headers)
        Alamofire.request(requestUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .response { (response) in
                let error = response.error
                if error == nil {
                    do{
                        let JSON = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String: AnyObject]
                        
                        onCompletion(nil,JSON)
                    } catch let error as NSError {
                        onCompletion(error,nil)
                    }
                } else {
                    onCompletion(error as NSError?, nil)
                }
        }
    }
}
