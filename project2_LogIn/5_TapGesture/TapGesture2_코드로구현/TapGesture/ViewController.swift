//
//  ViewController.swift
//  TpaGesture
//
//  Created by inooph on 2021/08/18.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    // 1~2번
    //@IBAction func tapView(_ sender: UITapGestureRecognizer) {
    //    self.view.endEditing(true)
    //}
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1. 인터페이스 빌더로 구현
        
        // 2. 타겟액션 - 코드로 구현
        //let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapView(_:)))
        //self.view.addGestureRecognizer(tapGesture)
        
        // 3. delegate
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
        tapGesture.delegate = self
        
        self.view.addGestureRecognizer(tapGesture)
    }
    
    // delegate가 응답을 주는 것, 사용자 터치 받아도 되는지
    // 상황에 맞게 정교한 작업 가능
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        let currentBool = false
        print("shouldReceive touch - currentBool (\(currentBool))")
        return currentBool
    }


}

