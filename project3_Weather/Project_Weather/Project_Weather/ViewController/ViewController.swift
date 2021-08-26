//
//  ViewController.swift
//  Project_Weather
//
//  Created by inooph on 2021/08/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier: String = "cell"
    var countries: [Country] = []
    
    /*
     [화면구성]
     - [ㅇ] 내비게이션 아이템의 타이틀은 "세계 날씨"입니다.
     - [ㅇ] 테이블뷰 셀 왼쪽에는 국기 이미지를 보여주며, 국기 이미지 오른쪽에는 국가 이름을 보여줍니다.
     - [ㅇ] 또, 셀의 악세서리뷰를 통해 다음 화면으로 이동 가능함을 표시합니다.
     
     [기능]
     - [ㅇ] 테이블뷰 셀을 선택하면 화면2로 전환됩니다.
     */
    //{"korean_name":"한국","asset_name":"kr"},
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "countries") else { return }
        
        do {
            self.countries = try jsonDecoder.decode([Country].self, from: dataAsset.data)
            print("데이터 불러오기 성공")
        } catch { print(error.localizedDescription) }
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ContryTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ContryTableViewCell else { return UITableViewCell() }
        let country: Country = countries[indexPath.row]
        cell.update(country)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cityListVC = segue.destination as? CityListViewController else { return }
        
        guard let cell = sender as? ContryTableViewCell else { return }
        cityListVC.title = cell.countryNameLabel.text
    }
}

