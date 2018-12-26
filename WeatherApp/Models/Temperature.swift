//
//  Temperature.swift
//  WeatherApp
//
//  Created by goodbox on 23/12/18.
//  Copyright © 2018 goodbox. All rights reserved.
//

import Foundation

public class Temperature {
    public var day : Double?
    public var min : Double?
    public var max : Double?
    public var night : Double?
    public var eve : Double?
    public var morn : Double?
    
   
    public class func modelsFromDictionaryArray(array:NSArray) -> [Temperature]
    {
        var models:[Temperature] = []
        for item in array
        {
            models.append(Temperature(dictionary: item as! NSDictionary)!)
        }
        return models
        
    }
    
    required public init?(dictionary: NSDictionary) {
        
        day = dictionary["day"] as? Double
        min = dictionary["min"] as? Double
        max = dictionary["max"] as? Double
        night = dictionary["night"] as? Double
        eve = dictionary["eve"] as? Double
        morn = dictionary["morn"] as? Double
    }

}
