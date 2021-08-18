//
//  ViewController.swift
//  TpaGesture
//
//  Created by inooph on 2021/08/18.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

