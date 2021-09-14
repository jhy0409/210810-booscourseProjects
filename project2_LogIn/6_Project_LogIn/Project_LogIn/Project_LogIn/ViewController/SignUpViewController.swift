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
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var AboutMe: UITextField!
    lazy var textFieldArr: [UITextField] = [idTextField, pwTextField, pwCheckTextField, AboutMe]
    @IBOutlet weak var nextButton: UIButton!
    
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true

        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingDelegate(textFieldArr)
        setImageView()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pickPhoto))
        profileImageView.addGestureRecognizer(tapGesture)
        profileImageView.isUserInteractionEnabled = true
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
        if  idTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty == false &&
                pwTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty == false &&
                pwCheckTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty == false &&
                AboutMe.text?.trimmingCharacters(in: .whitespaces).isEmpty == false &&
                pwTextField.text == pwCheckTextField.text &&
                profileImageView.image != nil {
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
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

// MARK: - UIImagePickerControllerDelegate
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    // 이미지 선택이 취소됐을 때
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("\nfunc -> imagePickerControllerDidCancel")
        checkValue()
        setImageView()
        self.dismiss(animated: true, completion: nil)
    }
    
    // 이미지가 선택됐을 때
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var tmpImg: UIImage?
        if let editedImg = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            tmpImg = editedImg
        } else if let editedImg = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            tmpImg = editedImg
        }
        profileImageView.image = tmpImg
        
        setImageView()
        checkValue()
        self.dismiss(animated: true, completion: nil)
    }
    
    func setImageView() {
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.cornerRadius = 10
        
        if profileImageView.image == nil {
            profileImageView.backgroundColor = .systemGray6
            profileImageView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            nextButton.isEnabled = false
        }
        else {
            profileImageView.backgroundColor = .systemBackground
            profileImageView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            nextButton.isEnabled = true
        }
    }
    
    func resetUserInfo() {
        NotificationCenter.default.post(name: NSNotification.Name("setTextField"), object: nil, userInfo: ["id" : ""])
        UserInformation.shared.userID = nil
        UserInformation.shared.birthDay = nil
        UserInformation.shared.phoneNumber = nil
    }
}
