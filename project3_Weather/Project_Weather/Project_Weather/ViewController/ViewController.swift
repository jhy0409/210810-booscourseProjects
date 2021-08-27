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
        cell.tmpC = country
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cityListVC = segue.destination as? CityListViewController else { return }
        
        guard let cell = sender as? ContryTableViewCell else { return }
        cityListVC.title = cell.countryNameLabel.text
        cityListVC.tmpCountry = cell.tmpC // 개별 나라를 세팅 -> 독일, 한국, 일본... -> '한국'
        
        print("\(String(describing: cityListVC.tmpCountry?.contName))") // 네비게이션 타이틀 설정 -> '한국'
    }
}

