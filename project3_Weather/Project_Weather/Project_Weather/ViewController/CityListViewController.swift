//
//  CityListViewController.swift
//  Project_Weather
//
//  Created by inooph on 2021/08/26.
//

import UIKit

class CityListViewController: UIViewController {
    /*
     [화면 2] - 도시 목록
      
     [화면구성]
     - [] 내비게이션 아이템의 타이틀은 이전 화면에서 선택된 국가 이름입니다.
     - [] 테이블뷰 셀
        - [] 셀 왼쪽에 해당 날씨에 맞는 이미지(비/구름/해/눈)를 보여줍니다.
        - [] 그리고 그 이미지 오른쪽에 도시명, 온도(섭씨/화씨), 강수확률을 보여줍니다.
        - [] 더불어 셀의 악세서리뷰를 표시해 다음 화면으로 이동 가능함을 나타냅니다.
     
     [기능]
     - [] 내비게이션 이전 버튼을 누르면 이전 화면으로 되돌아가며, 테이블뷰 셀을 선택하면 화면3으로 전환됩니다.
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
