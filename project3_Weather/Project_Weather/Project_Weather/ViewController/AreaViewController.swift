//
//  AreaViewController.swift
//  Project_Weather
//
//  Created by inooph on 2021/08/27.
//

import UIKit

class AreaViewController: UIViewController {
    var tmpCityArea: CityArea?
    
    @IBOutlet weak var areaWhether_ImgView: UIImageView!
    @IBOutlet weak var areaNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var rainfallLabel: UILabel!
    
    @IBOutlet weak var areaWeatherTop: NSLayoutConstraint!
    @IBOutlet weak var areaWeatherHeight: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        settingView()
    }
    
    func settingView() {
        areaWhether_ImgView.image = tmpCityArea?.weatherImg
        temperatureLabel.text = tmpCityArea?.celsiusAndFahrenheit
        temperatureLabel.textColor = tmpCityArea?.temperatureColor
        rainfallLabel.text = tmpCityArea?.rainStr
        rainfallLabel.textColor = tmpCityArea?.rainTxtColor
        areaNameLabel.text = tmpCityArea?.weatherStr
    }
    
    /*
     [화면 3] - 날씨 세부 정보

     [화면구성]
     - [ㅇ] 내비게이션 아이템의 타이틀은 이전 화면에서 선택된 도시 이름입니다.
     - [ㅇ] 화면 상단에는 날씨 이미지를 보여주고, 화면 하단에는 날씨 세부 정보를 문자열로 나타냅니다.
     
     [기능]
     없음
     */
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
        if UIDevice.current.orientation.isLandscape == true {
            print("------> 뷰가 가로")
            areaWeatherTop.constant = 50
            areaWeatherHeight.constant = 70
        }
        else if UIDevice.current.orientation.isLandscape == false {
            areaWeatherTop.constant = 80
            areaWeatherHeight.constant = 130
        }
    }
}
