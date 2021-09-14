//
//  AreaViewController.swift
//  Project_Weather
//
//  Created by inooph on 2021/08/27.
//

import UIKit

final class AreaViewController: UIViewController {
    var tmpCityArea: CityArea? // 셀에서 받은 지역정보
    
    @IBOutlet weak var areaWhether_ImgView: UIImageView!
    @IBOutlet weak var areaNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var rainfallLabel: UILabel!
    
    @IBOutlet weak var areaWeatherTop: NSLayoutConstraint!
    @IBOutlet weak var areaWeatherHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingView()
        guard let cityName = tmpCityArea?.cityName else { return }
        self.title = cityName
    }
    
    func settingView() {
        areaWhether_ImgView.image = tmpCityArea?.weatherImg         // 그림   - 날씨
        temperatureLabel.text = tmpCityArea?.celsiusAndFahrenheit   // 문자열  - 섭씨 화씨
        temperatureLabel.textColor = tmpCityArea?.temperatureColor  // 글자색  - 섭씨 화씨
        rainfallLabel.text = tmpCityArea?.rainString                // 문자열  - 강수확률
        rainfallLabel.textColor = tmpCityArea?.rainTxtColor         // 글자색  - 강수확률
        areaNameLabel.text = tmpCityArea?.weatherStr                // 문자열  - 비, 흐림 등..
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
        if UIDevice.current.orientation.isLandscape == true {
            print("------> 뷰가 가로")
            areaWeatherTop.constant = 50
            areaWeatherHeight.constant = 70
        } else {
            areaWeatherTop.constant = 80
            areaWeatherHeight.constant = 130
        }
    }
}
