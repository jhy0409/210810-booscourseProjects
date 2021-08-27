//
//  CityListViewController.swift
//  Project_Weather
//
//  Created by inooph on 2021/08/26.
//

import UIKit

class CityListViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    /*
     [화면 2] - 도시 목록
      
     [화면구성]
     - [ㅇ] 내비게이션 아이템의 타이틀은 이전 화면에서 선택된 국가 이름입니다.
     - [ㅇ] 테이블뷰 셀
        - [ㅇ] 셀 왼쪽에 해당 날씨에 맞는 이미지(비/구름/해/눈)를 보여줍니다.
        - [ㅇ] 그리고 그 이미지 오른쪽에 도시명, 온도(섭씨/화씨), 강수확률을 보여줍니다.
        - [ㅇ] 더불어 셀의 악세서리뷰를 표시해 다음 화면으로 이동 가능함을 나타냅니다.
     
     [기능]
     - [] 내비게이션 이전 버튼을 누르면 이전 화면으로 되돌아가며, 테이블뷰 셀을 선택하면 화면3으로 전환됩니다.
     */
    
    
    @IBOutlet weak var tableView: UITableView!
    var cities: [CityArea] = []
    var tmpCountry: Country?
    //var shortName: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        guard let shortName = tmpCountry?.shortName else { return }
        
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let dataAsset: NSDataAsset = NSDataAsset(name: shortName) else { return }
        
        do {
            self.cities = try jsonDecoder.decode([CityArea].self, from: dataAsset.data)
            
            
            print("데이터 불러오기 성공 / cities.count : \(cities.count) / \(shortName)")
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as? CityTableViewCell else { return UITableViewCell() }
        
        cell.update(cities[indexPath.row])
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let areaVC = segue.destination as? AreaViewController else { return }
        
        guard let cell = sender as? CityTableViewCell else { return }
        areaVC.tmpCityArea = cell.tmpCity
        areaVC.title = cell.tmpCity?.cityName

    }

}
