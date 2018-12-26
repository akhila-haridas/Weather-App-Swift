//
//  NetworkHelper.swift
//  WeatherApp
//
//  Created by goodbox on 24/12/18.
//  Copyright © 2018 goodbox. All rights reserved.
//

import Foundation
import Alamofire

class NetworkHelper {
    class func isConnected() -> Bool {
        return (NetworkReachabilityManager()?.isReachable)! 
    }
}
