
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by goodbox on 21/12/18.
//  Copyright © 2018 goodbox. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
    @IBOutlet weak var forecastTableView: UITableView?
    @IBOutlet weak var loader: UIActivityIndicatorView?
    var forecastArray = [Forecast]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if NetworkHelper.isConnected() {
            getWeatherForecast()
        } else {
            getSavedForecast()
        }
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.forecastTableView?.reloadData()
        }
    }
    
    func getWeatherForecast() {
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
        let urlString = latitude + longitude + "&cnt=16"
        let requestURL = kForecastAPI + urlString + kWeatherAPIKey
//        let requestURL = "https://samples.openweathermap.org/data/2.5/forecast/daily?lat=35&lon=139&cnt=10&appid=b1b15e88fa797225412429c1c50c122a1"
        APIClient.sharedInstance.fetchDictionaryDataWithGetRequest(requestUrl: requestURL, parameters: [:], headers: [:]) { (error, response) in
            self.loader?.stopAnimating()
            print(response)
            if error != nil {
                print("Error")
                return
            }
            if let list = response?["list"] as? NSArray {
                self.forecastArray = Forecast.modelsFromDictionaryArray(array: list)
                let userDefaults = UserDefaults.standard
                userDefaults.set(list, forKey: "forecastArray")
                userDefaults.synchronize()
                self.reloadTableView()
            }
        }
    }
    
    func getSavedForecast() {
        let userDefaults = UserDefaults.standard
        if let array = userDefaults.value(forKey: "forecastArray") as? NSArray {
            self.forecastArray = Forecast.modelsFromDictionaryArray(array: array)
            self.reloadTableView()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailForecastSegue" {
            let detailVC = segue.destination as! DetailForecastViewController
            detailVC.forecast = sender as? Forecast
        }
    }

}
extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let forecastCell = tableView.dequeueReusableCell(withIdentifier: "forecastTableCell") as? ForecastTableViewCell {
            return forecastCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let forecastCell = cell as? ForecastTableViewCell else { return }
        let forecast = forecastArray[indexPath.row]
        forecastCell.forecast = forecast
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let forecast = forecastArray[indexPath.row]
        self.performSegue(withIdentifier: "detailForecastSegue", sender: forecast)
    }
}
