//
//  SignUpThird_ViewController.swift
//  Project_LogIn
//
//  Created by inooph on 2021/08/18.
//

import UIKit

class SignUpThird_ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var tellTextField: UITextField! // 전화번호 텍스트필드
    @IBOutlet weak var birthLabel: UILabel! // 생년월일
    @IBOutlet weak var joinButton: UIButton! // 가입버튼
    
    var dateLabelChanged: Bool?
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "MMMM d, YYYY"
        return formatter
    }()
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        dateLabelChanged = true
        let date: Date = self.datePicker.date
        let dateStr: String = self.dateFormatter.string(from: date)
        self.dateLabel.text = dateStr
        checkValue()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: UIControl.Event.valueChanged)
        tellTextField.delegate = self // 델리게이트 설정
        
        ImportUserInformation()
        checkValue()
        guard let tmpIDStr = UserInformation.shared.userID else { return }
        NotificationCenter.default.post(name: NSNotification.Name("setTextField"), object: nil, userInfo: ["id" : "\(tmpIDStr)"])
    }
    
    
    @IBAction func joinButtonTapped(_ sender: Any) {
        dismissModal()
    }
    
    func checkValue() {
        if tellTextField.text?.trimmingCharacters(in: .whitespaces).count != 0 && dateLabelChanged == true {
            guard let tellStr = tellTextField.text, let birthStr = birthLabel.text else { return }
            
            UserInformation.shared.phoneNumber = tellStr
            UserInformation.shared.birthDay = birthStr
            joinButton.isEnabled = true
            print("\nThirdView checkValue() ----> tellTextField에 값이 있음")
        } else {
            print("\nThirdView checkValue() ----> tellTextField에 값이 없거나 생년월일이 변경되지 않음")
            joinButton.isEnabled = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkValue()
    }
    
    // MARK: - ImportUserInformation 유저정보 가져오기
    func ImportUserInformation() {
        if UserInformation.shared.birthDay != nil && UserInformation.shared.phoneNumber != nil {
            tellTextField.text = UserInformation.shared.phoneNumber
            dateLabel.text = UserInformation.shared.birthDay
            dateLabelChanged = true
        } else {
            dateLabel.text = dateFormatter.string(from: datePicker.date) // 라벨 초기값
        }
    }
    
    // MARK: - [ㅇ] '이전' 버튼을 누르면 현재 정보를 저장해두고 화면2로 돌아가며,
    @IBAction func beforeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - [ㅇ] 취소 버튼 : '취소' 버튼을 누르면 모든 정보가 지워지고 화면1로 돌아갑니다.
    @IBAction func cancleButtonTapped(_ sender: Any) {
        print("\n---> cancleButtonTapped")
        resetUserInfo() // 취소버튼을 누르면 저장값 모두 지움
        dismissModal() // 모달 다 끄기
    }
    
    // MARK: - 키보드내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func resetUserInfo() {
        NotificationCenter.default.post(name: NSNotification.Name("setTextField"), object: nil, userInfo: ["id" : ""])
        UserInformation.shared.userID = nil
        UserInformation.shared.birthDay = nil
        UserInformation.shared.phoneNumber = nil
    }
    
    func dismissModal() {
        var vc: UIViewController = self
        while vc.presentingViewController != nil {
            vc = vc.presentingViewController!
        }
        vc.dismiss(animated: true, completion: nil)
    }
}
