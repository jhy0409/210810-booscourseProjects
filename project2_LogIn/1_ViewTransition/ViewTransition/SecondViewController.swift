//
//  SecondViewController.swift
//  ViewTransition
//
//  Created by inooph on 2021/08/16.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\n1. SecondViewController의 view가 메모리에 로드 됨\t\t-viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.nameLabel.text = UserInformation.shared.name
        self.ageLabel.text = UserInformation.shared.age
        print("2. SecondViewController의 view가 화면에 보여질 예정\t-viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("3. SecondViewController의 view가 화면에 보여짐\t\t-viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("4. SecondViewController의 view가 화면에서 사라질 예정\t-viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("5. SecondViewController의 view가 화면에서 사라짐\t\t-viewDidDisappear")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("6. SecondViewController의 view가 레이아웃 하려함\t\t-viewWillLayoutSubviews")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("7. SecondViewController의 subview를 레이아웃 함\t\t-viewDidLayoutSubviews")
    }
    
    
    @IBAction func popToPrev() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dismissModal() {
        self.dismiss(animated: true, completion: nil)
    }
    /*
     push - pop : 네비게이션 컨트롤러
     예시 ) 설정탭
     
     present - dismiss : 단순한 팝업, 입력폼
     */
}
