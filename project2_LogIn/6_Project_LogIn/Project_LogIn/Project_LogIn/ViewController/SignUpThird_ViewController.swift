//
//  SignUpThird_ViewController.swift
//  Project_LogIn
//
//  Created by inooph on 2021/08/18.
//

import UIKit

class SignUpThird_ViewController: UIViewController {
    /*
     
     * 화면구성
     [ㅇ] 화면 상단에는 전화번호를 입력할 수 있는 텍스트 필드가 있습니다.
     [ㅇ] 텍스트 필드 하단에는 선택한 생년월일을 표시할 수 있는 레이블이 있으며 그 하단에는 날짜를 선택할 수 있는 피커가 있습니다.
     [ㅇ] 피커 하단에는 '이전', '취소', '가입' 버튼이 위치합니다.
     
     * 기능
     [] 사용자가 모든 정보를 기입한 상태가 아니라면 '가입' 버튼은 기본적으로 비활성화되어있습니다.
     [] 전화번호와 생년월일이 채워지면 '가입' 버튼이 활성화됩니다.
     [] 또, 활성화된 '가입' 버튼을 선택하면 화면1로 되돌아가고, 가입한 아이디가 화면1의 아이디 필드에 입력되어있습니다.
     [] '이전' 버튼을 누르면 현재 정보를 저장해두고 화면2로 돌아가며, '취소' 버튼을 누르면 모든 정보가 지워지고 화면1로 돌아갑니다.
     
     [] 전화번호 필드를 누르면 숫자키패드가 올라옵니다.
     [] 생년월일 선택은 UIDatePicker를 활용합니다.
     [] UIDatePicker의 숫자가 바뀌면 생년월일 레이블에 즉각 반영됩니다.
      
     Singleton 구현

     [] 애플리케이션 구현에 필요한 싱글턴 인스턴스를 생성하여 활용합니다.
     [] 싱글턴 클래스 이름은 UserInformation으로 합니다.
     */
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
