//
//  Weather.swift
//  WeatherApp
//
//  Created by goodbox on 23/12/18.
//  Copyright © 2018 goodbox. All rights reserved.
//

import Foundation

public class Weather {
    var iD: Int?
    var main: String?
    var descriptionText: String?
    var icon: String?
   
    init () {
        
    }
    
    init(json: [String: Any]) {
        self.iD = json["iD"] as? Int
        self.main = json["main"] as? String
        self.descriptionText = json["description"] as? String
        self.icon = json["icon"] as? String
    }
    
    public class func modelsFromDictionaryArray(array: NSArray) -> [Weather]
    {
        var models:[Weather] = []
        for item in array
        {
            models.append(Weather(json: item as! [String : Any]))
        }
        return models
    }
}
