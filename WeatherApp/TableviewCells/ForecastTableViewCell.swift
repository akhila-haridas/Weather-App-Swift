//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by goodbox on 23/12/18.
//  Copyright © 2018 goodbox. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    @IBOutlet weak var lblDate: UILabel?
    @IBOutlet weak var lblDescription : UILabel?
    
    var forecast: Forecast? {
        didSet {
            if let unixTimeStamp = forecast?.dt {
                let date = Date(timeIntervalSince1970: unixTimeStamp)
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
                dateFormatter.locale = NSLocale.current
                dateFormatter.dateFormat = "yyyy MMM,dd HH:mm a" //Specify your format that you want
                let strDate = dateFormatter.string(from: date)
                lblDate?.text = strDate
            }
          //  lblDate?.text = String(format: "%f", forecast?.dt ?? 0)
            if let weatherArr = forecast?.weather {
                if weatherArr.count > 0 {
                    let weather = weatherArr[0] 
                    lblDescription?.text = weather.descriptionText
                }
            }
        }
    }
}
