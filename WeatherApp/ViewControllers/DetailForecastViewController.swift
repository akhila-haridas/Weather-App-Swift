//
//  DetailForecastViewController.swift
//  WeatherApp
//
//  Created by goodbox on 23/12/18.
//  Copyright © 2018 goodbox. All rights reserved.
//

import UIKit
import MessageUI

class DetailForecastViewController: UIViewController,MFMessageComposeViewControllerDelegate {
    @IBOutlet weak var lblMinTemp: UILabel?
    @IBOutlet weak var lblMaxTemp: UILabel?
    @IBOutlet weak var lblHumidity: UILabel?
    @IBOutlet weak var lblPressure: UILabel?
    @IBOutlet weak var lblDescription: UILabel?
    var temperature: Temperature?
    var forecast: Forecast?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if forecast != nil {
            lblDescription?.text = forecast?.weather?[0].descriptionText
            lblMinTemp?.text = Utils.getTemperatureInCelcius(kelvin: forecast?.temp?.min ?? 0)
            lblMaxTemp?.text = Utils.getTemperatureInCelcius(kelvin: forecast?.temp?.max ?? 0)
            lblPressure?.text = String(format: "%f", forecast?.pressure ?? 0)
            lblHumidity?.text = String(format: "%f", forecast?.humidity ?? 0)
        }
    }
    
    @IBAction func shareTextButton(_ sender: UIBarButtonItem) {
        
        let text = "Temp Min: \(Utils.getTemperatureInCelcius(kelvin: forecast?.temp?.min ?? 0)), Temp Max: \(Utils.getTemperatureInCelcius(kelvin: forecast?.temp?.max ?? 0))"
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = text
            controller.recipients = []
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
        
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }

}
