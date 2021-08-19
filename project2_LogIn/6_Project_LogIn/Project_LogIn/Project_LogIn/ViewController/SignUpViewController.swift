//
//  SignUpViewController.swift
//  Project_LogIn
//
//  Created by inooph on 2021/08/18.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var pwCheckTextField: UITextField!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var AboutMe: UITextField!
    lazy var textFieldArr: [UITextField] = [idTextField, pwTextField, pwCheckTextField, AboutMe]
    @IBOutlet weak var nextButton: UIButton!
    
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingDelegate(textFieldArr)
        imgViewSetting()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pickPhoto))
        profileImg.addGestureRecognizer(tapGesture)
        profileImg.isUserInteractionEnabled = true
    }
    
    @objc func pickPhoto() {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    // [ㅇ] 취소버튼 이전화면 전환
    @IBAction func cancleBtnTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        resetUserInfo()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkValue()
    }
    
    func checkValue() {
        if  idTextField.text?.trimmingCharacters(in: .whitespaces).count != 0 &&
                pwTextField.text?.trimmingCharacters(in: .whitespaces).count != 0 &&
                pwCheckTextField.text?.trimmingCharacters(in: .whitespaces).count != 0 &&
                AboutMe.text?.trimmingCharacters(in: .whitespaces).count != 0 &&
                pwTextField.text == pwCheckTextField.text &&
                profileImg.image != nil {
            nextButton.isEnabled = true
            
            // MARK: - 아이디값 저장
            if let idString = idTextField.text { UserInformation.shared.userID = idString }
        } else { print("알림 - 유효하지 않은 값, 모든 값을 채우십시오"); nextButton.isEnabled = false }
    }
    
    func settingDelegate(_ textFieldArr: [UITextField]) {
        for i in textFieldArr {
            i.delegate = self
        }
    }
    
    // [ㅇ] 키보드 올리고 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: - UIImagePickerControllerDelegate
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    // 이미지 선택이 취소됐을 때
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("\nfunc -> imagePickerControllerDidCancel")
        checkValue()
        imgViewSetting()
        self.dismiss(animated: true, completion: nil)
    }
    
    // 이미지가 선택됐을 때
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage: UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.profileImg.image = originalImage
        }
        print("\nfunc -> imagePickerController didFinishPickingMediaWithInfo")
        
        imgViewSetting()
        checkValue()
        self.dismiss(animated: true, completion: nil)
    }
    
    func imgViewSetting() {
        profileImg.layer.borderWidth = 1
        profileImg.layer.cornerRadius = 10
        
        if profileImg.image == nil {
            profileImg.backgroundColor = .systemGray6
            profileImg.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            nextButton.isEnabled = false
        }
        else {
            profileImg.backgroundColor = .systemBackground
            profileImg.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            nextButton.isEnabled = true
        }
        print("\n\n--> imgViewSetting func")
    }
    
    func resetUserInfo() {
        NotificationCenter.default.post(name: NSNotification.Name("setTextField"), object: nil, userInfo: ["id" : ""])
        UserInformation.shared.userID = nil
        UserInformation.shared.birthDay = nil
        UserInformation.shared.tellNum = nil
    }
}
