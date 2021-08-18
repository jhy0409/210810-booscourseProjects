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
        
        세팅_델리게이트(textFieldArr)
        imgViewSetting()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pickPhoto))
        profileImg.addGestureRecognizer(tapGesture)
        profileImg.isUserInteractionEnabled = true
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
    
    @objc func pickPhoto() {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    // [ㅇ] 취소버튼 이전화면 전환
    @IBAction func cancleBtnTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // [ㅇ] 예외처리 - '다음' 버튼은 기본적으로 비활성화
    //  - [ㅇ] 조건 1. 사용자가 모든 정보를 기입한 상태 (2~3)
    //  - [ㅇ] 조건 2. 프로필 이미지
    //  - [ㅇ] 조건 3. 아이디, 자기소개, 패스워드가 일치
    func textFieldDidEndEditing(_ textField: UITextField) {
        유효값검사()
    }
    func 유효값검사() {
        if  idTextField.text?.trimmingCharacters(in: .whitespaces).count != 0 &&
            pwTextField.text?.trimmingCharacters(in: .whitespaces).count != 0 &&
            pwCheckTextField.text?.trimmingCharacters(in: .whitespaces).count != 0 &&
            AboutMe.text?.trimmingCharacters(in: .whitespaces).count != 0 &&
            pwTextField.text == pwCheckTextField.text &&
            profileImg.image != nil {
            nextButton.isEnabled = true
        } else { print("알림 - 유효하지 않은 값, 모든 값을 채우십시오"); nextButton.isEnabled = false }
    }
    func 세팅_델리게이트(_ textFieldArr: [UITextField]) {
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
/*
 [ㅇ] 상단 왼쪽의 이미지뷰를 탭하면 UIImagePickerController가 뜨고, 이미지를 간단히 편집해 프로필 사진으로 선택할 수 있습니다.
 [ㅇ] 프로필 이미지뷰는 정사각형이며, 이미지뷰 내부에 보이는 이미지는 이미지 원래의 비율을 유지합니다.
 [ㅇ] 화면 중간의 텍스트 뷰에서 자기소개를 작성할 수 있습니다.
 [] 화면 왼쪽 하단의 '취소' 버튼을 누르면 모든 정보가 지워지고 이전 화면1로 되돌아갑니다.
 
 [ㅇ] 사용자가 모든 정보를 기입한 상태가 아니라면 화면 오른쪽 하단의 '다음' 버튼은 기본적으로 비활성화되어있으며,
 [ㅇ] 프로필 이미지, 아이디, 자기소개가 모두 채워지고, 패스워드가 일치하면 '다음' 버튼이 활성화됩니다.
 */
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    // 이미지 선택이 취소됐을 때
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("\nfunc -> imagePickerControllerDidCancel")
        유효값검사()
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
        유효값검사()
        self.dismiss(animated: true, completion: nil)
    }
}
