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
        
        let date: Date = self.datePicker.date
        let dateStr: String = self.dateFormatter.string(from: date)
        self.dateLabel.text = dateStr
    }
    
    /*
     * 화면구성 =============================================================
     
     [ㅇ] 화면 상단에는 전화번호를 입력할 수 있는 텍스트 필드가 있습니다.
     [ㅇ] 텍스트 필드 하단에는 선택한 생년월일을 표시할 수 있는 레이블이 있으며 그 하단에는 날짜를 선택할 수 있는 피커가 있습니다.
     [ㅇ] 피커 하단에는 '이전', '취소', '가입' 버튼이 위치합니다.
     
     * 기능 ================================================================
     
     [ㅇ] 사용자가 모든 정보를 기입한 상태가 아니라면 '가입' 버튼은 기본적으로 비활성화되어있습니다.
     [ㅇ] 전화번호와 생년월일이 채워지면 '가입' 버튼이 활성화됩니다.
     [] 또, 활성화된 '가입' 버튼을 선택하면 화면1로 되돌아가고, 가입한 아이디가 화면1의 아이디 필드에 입력되어있습니다.
     [ㅇ] '이전' 버튼을 누르면 현재 정보를 저장해두고 화면2로 돌아가며,
     [ㅇ] '취소' 버튼을 누르면 모든 정보가 지워지고 화면1로 돌아갑니다.
     
     [ㅇ] 전화번호 필드를 누르면 숫자키패드가 올라옵니다.
     [ㅇ] 생년월일 선택은 UIDatePicker를 활용합니다.
     [ㅇ] UIDatePicker의 숫자가 바뀌면 생년월일 레이블에 즉각 반영됩니다.
      
     * Singleton 구현 ======================================================
     [ㅇ] 애플리케이션 구현에 필요한 싱글턴 인스턴스를 생성하여 활용합니다. / 저장 - [뷰2] : 아이디, [뷰3] : 전화번호, 생일
     [ㅇ] 싱글턴 클래스 이름은 UserInformation으로 합니다.
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: UIControl.Event.valueChanged)
        tellTextField.delegate = self // 델리게이트 설정
        
        ImportUserInformation()
        checkValue()
    }
    
    @IBAction func joinButtonTapped(_ sender: Any) {
        dismissModal()
    }
    
    func checkValue() {
        if tellTextField.text?.trimmingCharacters(in: .whitespaces).count != 0 {
            guard let tellStr = tellTextField.text, let birthStr = birthLabel.text else { return }
            UserInformation.shared.tellNum = tellStr
            UserInformation.shared.birthDay = birthStr
            
            joinButton.isEnabled = true
            
             print("\n유효값검사() ----> tellTextField에 값이 있음")
        } else {
            print("\n유효값검사() ----> tellTextField에 값이 없음")
            joinButton.isEnabled = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkValue()
    }
    
    // MARK: - ImportUserInformation 유저정보 가져오기
    func ImportUserInformation() {
        if UserInformation.shared.birthDay != nil && UserInformation.shared.tellNum != nil {
            tellTextField.text = UserInformation.shared.tellNum
            dateLabel.text = UserInformation.shared.birthDay
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
        
        dismissModal()
    }
    
    // MARK: - 키보드내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func resetUserInfo() {
        UserInformation.shared.userID = nil
        UserInformation.shared.birthDay = nil
        UserInformation.shared.tellNum = nil
    }
    
    func dismissModal() {
        var vc: UIViewController = self
        while vc.presentingViewController != nil {
            vc = vc.presentingViewController!
        }
        vc.dismiss(animated: true, completion: nil)
    }
    
}
