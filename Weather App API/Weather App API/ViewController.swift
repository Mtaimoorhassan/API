//
//  ViewController.swift
//  Weather App API
//
//  Created by Muhammad Taimoor Hassan on 28/03/2023.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    var climate = WeatherData()
    var wData = Weather()
    var cityName = ""
    var activityView: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        temperature.text = "22"
        location.text = "Current Position"
    }
    
    //MARK: Search Location Button Pressed
    
    @IBAction func searchBtnPressed(_ sender: Any) {
        searchTextField.endEditing(true)
        cityName = searchTextField.text ?? "Lahore"
        print(cityName)
        if cityName == "" {
            showSimpleAlert(message: "Fill Text Fields")
        } else {
            fetchData()
        }
    }
    //MARK: Current Location Button Pressed
    
    @IBAction func currentLocationPressed(_ sender: Any) {
        print("Self Current Location Btn Pressed.")
    }
    
    //MARK: FetchData
    func fetchData() {
        // creating url
        let url = climate.getAPIUrl(name: cityName)
        print("apiCall:",url)
        // creating url request
        let urlRequest = URLRequest(url: url)
        // creating url session task
        let task = URLSession.shared.dataTask(with: urlRequest) {data, response, error in
            if let data {
                if let decoding = try? JSONDecoder().decode(WeatherData.self, from: data) {
                    self.climate = decoding
                    print("This is API Decoded:", decoding)
                    
                    // background thread to main thread.
                    
                    DispatchQueue.main.async { [self] in
                        updateUI(decode: decoding)
                        
                    }
                    
                }
            }
            if let error {DispatchQueue.main.async { [self] in
            showSimpleAlert(message: error.localizedDescription)
            }
                
            }
        }
        task.resume()
    }
    
    //MARK: showSimpleAlert
    func showSimpleAlert(message : String) {
        let alert = UIAlertController(title: "Error!", message: message,  preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: UI Update
    func updateUI(decode: WeatherData) {
        let temp = String(format: "%.0f", decode.main?.temp ?? -1)
        self.cityName = decode.name!

        print(temp ,"is the temperatue in ",cityName)

        self.temperature.text = "\(temp)"
        self.descriptionLbl.text = decode.weather?[0].description
        self.location.text = decode.name!
       
        let imageName = fetchImage(weatherID: decode.weather?[0].id ?? -1)
        print("------------------------------")
        print(imageName)
        print("------------------------------")
        image.image = UIImage(systemName: imageName)
        
    }
    //MARK: fetchImage
    func fetchImage(weatherID:Int) -> String {
        
        print("Fetch Image Function Called")
        
          switch (weatherID) {
           case 200 ... 232:
              return "cloud.bolt"
              
          case 300 ... 321:
                  return "cloud.rain"
              
          case 500 ... 531:
                  return "cloud.sun.rain"
                            
          case 600 ... 622:
                  return "cloud.snow"
              
          case 700 ... 881:
                  return "cloud"
              
          case 800:
                  return "sun.max"
              
          case 801 ... 805:
                  return "cloud.sun"
          default:
               return "face.dashed"
        }
    }
    
}

