//
//  ViewController.swift
//  Project_LogIn
//
//  Created by inooph on 2021/08/18.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var cloudButtonFromTop: NSLayoutConstraint!
    @IBOutlet weak var cloudButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var idTextFieldTop: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idTextField.delegate = self
        
        print("\n\n -----> ViewController viewDidLoad()")
        NotificationCenter.default.addObserver(self, selector: #selector(setTextField(_:)), name: NSNotification.Name("setTextField"), object: nil)
    }
    
    @objc func setTextField(_ notification: NSNotification) {
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
        UserInformation.shared.phoneNumber = nil
        UserInformation.shared.birthDay = nil
    }
    
    // MARK: - 뷰 회전
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        if UIDevice.current.orientation.isLandscape == true {
            print("------> 뷰가 가로")
            cloudButtonFromTop.constant = 50
            cloudButtonWidth.constant = 100
            idTextFieldTop.constant = 20
        } else { // 뷰가 세로"
            cloudButtonFromTop.constant = 100
            cloudButtonWidth.constant = 160
            idTextFieldTop.constant = 50
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

