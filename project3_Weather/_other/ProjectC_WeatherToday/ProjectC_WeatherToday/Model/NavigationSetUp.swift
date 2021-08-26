//
//  NavigationSetUp.swift
//  ProjectC_WeatherToday
//
//  Created by 김광준 on 2019/12/04.
//  Copyright © 2019 VincentGeranium. All rights reserved.
//

import Foundation
import UIKit

let mainVC = MainViewController()

// MARK: - setupNaviController
/// 모든 뷰컨에 들어가는 공통적인 네이게이션 바 셋팅

func setupNaviController(self: UIViewController) {
      
    self.navigationController?.navigationBar.backItem?.title = mainVC.mainVCTitle
    self.navigationController?.navigationBar.tintColor = UIColor.white
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 0.239, green: 0.675, blue: 0.969, alpha: 0)
  }
  

