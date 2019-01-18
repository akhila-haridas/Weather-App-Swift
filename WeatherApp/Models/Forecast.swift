//
//  Forecast.swift
//  WeatherApp
//
//  Created by goodbox on 23/12/18.
//  Copyright © 2018 goodbox. All rights reserved.
//

import Foundation
public class Forecast {
    public var dt : Double?
   // public var temp : Temperature?
    public var main : Main?
//    public var humidity : Int?
    public var weather : Array<Weather>?
//    public var speed : Double?
//    public var deg : Int?
//    public var clouds : Int?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [Forecast]
    {
        var models:[Forecast] = []
        for item in array
        {
            models.append(Forecast(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {
        
        dt = dictionary["dt"] as? Double
        if (dictionary["main"] != nil) {// temp = Temperature(dictionary: dictionary["temp"] as! NSDictionary) }
            main = Main(dictionary: dictionary["main"] as! NSDictionary)
        }
        if (dictionary["weather"] != nil) { weather = Weather.modelsFromDictionaryArray(array: dictionary["weather"] as! NSArray) }
       
}

}
