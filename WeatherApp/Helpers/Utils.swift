//
//  Utils.swift
//  WeatherApp
//
//  Created by goodbox on 23/12/18.
//  Copyright © 2018 goodbox. All rights reserved.
//

import Foundation

class Utils {

    static func getTemperatureInCelcius(kelvin: Double) -> String {
        let celsiusTemp = kelvin - 273.15
        return String(format: "%.0f", celsiusTemp) + "℃"
    }
    
}
