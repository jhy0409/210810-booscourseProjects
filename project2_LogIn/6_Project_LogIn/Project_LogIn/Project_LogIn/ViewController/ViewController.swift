//
//  ViewController.swift
//  Project_LogIn
//
//  Created by inooph on 2021/08/18.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var idTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idTextField.delegate = self
        
        print("\n\n -----> ViewController viewDidLoad()")
        NotificationCenter.default.addObserver(self, selector: #selector(test(_:)), name: NSNotification.Name("test"), object: nil)
    }
    
    @objc func test(_ notification: NSNotification) {
        if UserInformation.shared.userID == nil {
            idTextField.text = ""
        }
        else {
            idTextField.text = notification.userInfo!["id"] as? String
        }
    }
    
    @IBAction func signUpNUserInfoReset(_ sender: UIButton) {
        print("\n\n\n-------> signUpNUserInfoReset")
        UserInformation.shared.userID = nil
        UserInformation.shared.tellNum = nil
        UserInformation.shared.birthDay = nil
    }
}

