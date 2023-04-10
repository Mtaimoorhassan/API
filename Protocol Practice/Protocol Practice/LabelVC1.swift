//  LabelVC.swift
//  Protocol Practice
//  Created by Muhammad Taimoor Hassan on 03/04/2023.

import UIKit

class LabelVC1: UIViewController, NameAndRollNo {
    
    func dataUpdated(name: String, rollNo: String) {
        nameLbl.text = name
        rollNoLbl.text = rollNo
    }
    

    @IBOutlet weak var rollNoLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func nextControllerBtnPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TextFieldVC") as! TextFieldVC
        vc.nameDelegate = self
         navigationController?.pushViewController(vc,
         animated: true)
    }
    
}
