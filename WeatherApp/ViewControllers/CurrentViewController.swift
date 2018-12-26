//
//  CurrentViewController.swift
//  WeatherApp
//
//  Created by goodbox on 21/12/18.
//  Copyright © 2018 goodbox. All rights reserved.
//

import UIKit
import CoreLocation

class CurrentViewController: UIViewController {
    @IBOutlet weak var lblTemp: UILabel?
    @IBOutlet weak var lblPlace: UILabel?
    @IBOutlet weak var weatherDescription: UILabel?
    @IBOutlet weak var loader: UIActivityIndicatorView?
    var timer: Timer?
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        locManager.requestAlwaysAuthorization()
       // locManager.delegate = self
        currentLocation = locManager.location
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if NetworkHelper.isConnected() {
            getCurrentWeather()
        } else {
            getSavedWeather()
        }
    }
   
    func saveCurrentWeather(weatherData: NSDictionary) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(weatherData, forKey: "currentWeather")
        userDefaults.synchronize()
    }
    
    func getSavedWeather() {
        let userDefaults = UserDefaults.standard
        if let weatherData = userDefaults.value(forKey: "currentWeather") as? NSDictionary {
            self.setWeatherData(weatherData: weatherData)
        }
    }
    
    func setWeatherData(weatherData: NSDictionary) {
        if let main = weatherData["main"] as? [String: Any] {
            if let kelvinTemp = main["temp"] as? Double {
                self.lblTemp?.text = Utils.getTemperatureInCelcius(kelvin: kelvinTemp)
            }
        }
        if let name = weatherData["name"] as? String {
            self.lblPlace?.text = name
        }
        if let weatherArr = weatherData["weather"] as? [[String: Any]] {
            if weatherArr.count > 0 {
                let weatherObj = Weather(json: weatherArr[0])
                self.weatherDescription?.text = weatherObj.descriptionText
            }
        }
    }
    
    func setTimer() {
        if NetworkHelper.isConnected() {
            timer = Timer.scheduledTimer(timeInterval: 30.0, target: self, selector: #selector(getCurrentWeather), userInfo: nil, repeats: false)
        } else {
            getSavedWeather()
        }
    }
    
    @objc func getCurrentWeather() {
        loader?.startAnimating()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var latitude = "lat="
        var longitude = "&lon="
       // print(appDelegate.currentLocation.coordinate.latitude)
        if let location = appDelegate.currentLocation {
            latitude = "lat=" + "\(String(describing: appDelegate.currentLocation.coordinate.latitude))"
            longitude = "&lon=" + "\(String(describing: appDelegate.currentLocation.coordinate.longitude))"
        } else {
            latitude = latitude + "12.972442"
            longitude = longitude + "77.580643"
        }
        let requestURL  = kCurrentWeatherAPI + latitude + longitude + kWeatherAPIKey
        APIClient.sharedInstance.fetchDictionaryDataWithGetRequest(requestUrl: requestURL, parameters: [:], headers: [:]) { (error, response) in
            self.loader?.stopAnimating()
            if error != nil {
                print("Error")
                self.getSavedWeather()
                return
            }
            self.setWeatherData(weatherData: response as! NSDictionary)
            self.saveCurrentWeather(weatherData: response! as NSDictionary)
            self.setTimer()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
