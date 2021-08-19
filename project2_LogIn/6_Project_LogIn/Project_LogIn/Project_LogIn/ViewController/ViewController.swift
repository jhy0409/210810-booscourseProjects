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
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        print("\n\n -----> ViewController viewWillAppear()")
//    }
}

