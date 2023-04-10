//
//  ViewController.swift
//  Protocol Practice
//
//  Created by Muhammad Taimoor Hassan on 03/04/2023.
//

import UIKit

class TextFieldVC: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
   
    @IBOutlet weak var rollNoTf: UITextField!
     
    var nameDelegate : NameAndRollNo? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonPressed(_ sender: Any) {
        print("Send Data Button Pressed")
        nameDelegate?.dataUpdated(name: "\(nameTF.text)", rollNo: "\(rollNoTf.text)")
        
    }
    
    
}

