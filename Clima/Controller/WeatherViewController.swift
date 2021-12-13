//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weather = WeatherManager(temperature: 0)
    var currentWeather: WeatherModel?
    let locationManager = CLLocationManager()
   

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self

        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        searchTextField.delegate = self
        weather.weatherDelegate = self
    }
    
    @IBAction func currentLocation(_ sender: Any) {
        locationManager.requestLocation()

    }
    
}

extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
                return true
        } else {
            textField.placeholder = "Type Something"
            return false
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("this is the start")
        if let location = textField.text{
            weather.fetchWeather(name: location)
        }
        searchTextField.text = ""
    }
    
}

extension WeatherViewController: WeatherProtocol{
    
    func updateWeather(_ weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperature
            self.cityLabel.text = weather.cityName
            self.conditionImageView.image = UIImage.init(systemName: weather.conditionname)
            
        }
        
    }
}

extension WeatherViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weather.fetchWeather(latitude: lat, longitude: lon)
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
