//
//  ViewController.swift
//  GestureRecognizer
//
//  Created by inooph on 2021/08/17.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 액션 타깃을 통한 제스처 인식기 초기화 및 생성
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapView(gestureRecognizer:)))
        
        // 뷰에 제스처 인식기 연결하기
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    // 액션 메서드
    @IBAction func tapView(gestureRecognizer: UITapGestureRecognizer) {
        print("View Tapped")
    }
    //@IBAction func tapView(_ sender: UITapGestureRecognizer) {
    //    print("View Tapped")
    //}
}

