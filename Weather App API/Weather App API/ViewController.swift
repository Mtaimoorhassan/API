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
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        temperature.text = "22"
        location.text = "Pakistan"
    }

    @IBAction func searchBtnPressed(_ sender: Any) {
        searchTextField.endEditing(true)
        print(searchTextField.text ?? "Pakistan" )
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text ?? "Pakistan" )
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchTextField.text = ""
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != "" {
            return true
        } else {
            return false
        }
    }
    
    @IBAction func myLocationBtnPressed(_ sender: Any) {
    }
}

