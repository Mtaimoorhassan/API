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
    
    var climate = WeatherData()
    var cityName = ""
    var activityView: UIActivityIndicatorView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        temperature.text = "22"
        location.text = "Current Position"
    }
    
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
    
    @IBAction func currentLocationPressed(_ sender: Any) {
        print("Self Current Location Btn Pressed.")
    }
    
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
                    print(decoding)
                    
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
    
    
    func showSimpleAlert(message : String) {
        let alert = UIAlertController(title: "Error!", message: message,  preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
            //Cancel Action
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    //MARK: UI Update
    func updateUI(decode: WeatherData) {
        let temp = String(format: "%.0f", decode.main?.temp ?? -1)
        self.cityName = decode.name!
        self.temperature.text = "\(temp)"
        self.location.text = decode.name!
        let newImg: UIImage? = UIImage(systemName: "face.smiling")
        image.image = newImg
        
    }
}
