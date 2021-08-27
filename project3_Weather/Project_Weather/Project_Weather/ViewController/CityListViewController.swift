//
//  CityListViewController.swift
//  Project_Weather
//
//  Created by inooph on 2021/08/26.
//

import UIKit

class CityListViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var cities: [CityArea] = [] // 한국 -> '춘천', '서울', ...
    var tmpCountry: Country?    // decode용. 'kr.json, de.json'... 나라 이름 필요
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        guard let shortName = tmpCountry?.shortName else { return } // ko, de, jp 등
        
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
        areaVC.tmpCityArea = cell.tmpCity // 세번째뷰 '춘천'(CityArea) = 두번째 뷰의 선택셀의 지역값으로 할당 ('춘천'(CityArea))
        areaVC.title = cell.tmpCity?.cityName // 세번째 뷰 네비게이션 타이틀 = 두번째뷰 선택셀의 도시 이름
    }
}
