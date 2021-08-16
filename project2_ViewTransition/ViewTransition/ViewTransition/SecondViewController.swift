//
//  SecondViewController.swift
//  ViewTransition
//
//  Created by inooph on 2021/08/16.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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
