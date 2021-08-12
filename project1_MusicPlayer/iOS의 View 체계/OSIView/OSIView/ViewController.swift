//
//  ViewController.swift
//  OSIView
//
//  Created by inooph on 2021/08/12.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         // 서브뷰 생성
         let frame = CGRect(x: 60, y: 100, width: 240, height: 120)
         let subView = UIView(frame: frame)
         
         // 서브뷰 색상
         subView.backgroundColor = UIColor.yellow
         
         // 서브뷰 추가하기
         view.addSubview(subView)
         
         // 서브뷰 제거하기
         subView.removeFromSuperview()
         */
        
//        let viewRect = CGRect(x: 100, y: 100, width: 200, height: 200)
        let viewRect = CGRect(x: 100, y: 100, width: 200, height: 200)
        let subView = UIView(frame: viewRect)
        subView.backgroundColor = UIColor.blue
        
        print("서브뷰 프레임의 CGRect : \(subView.frame)")
        print("서브뷰 바운드의 CGRect : \(subView.bounds)")
        print("서브뷰 프레임의 CGRect : \(subView.frame.origin)")
        print("서브뷰 바운드의 CGRect : \(subView.bounds.origin)")
        
        self.view.addSubview(subView)
    }
}

