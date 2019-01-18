//
//  Temperature.swift
//  WeatherApp
//
//  Created by goodbox on 23/12/18.
//  Copyright © 2018 goodbox. All rights reserved.
//

import Foundation

public class Main {
    public var temp : Double?
    public var temp_min : Double?
    public var temp_max : Double?
    public var pressure : Double?
    public var humidity : Double?
    
   
    public class func modelsFromDictionaryArray(array:NSArray) -> [Main]
    {
        var models:[Main] = []
        for item in array
        {
            models.append(Main(dictionary: item as! NSDictionary)!)
        }
        return models
        
    }
    
    required public init?(dictionary: NSDictionary) {
        
        temp = dictionary["temp"] as? Double
        temp_min = dictionary["temp_min"] as? Double
        temp_max = dictionary["temp_max"] as? Double
        pressure = dictionary["pressure"] as? Double
        humidity = dictionary["humidity"] as? Double
    }

}
