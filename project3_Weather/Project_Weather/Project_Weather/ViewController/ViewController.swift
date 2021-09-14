//
//  ViewController.swift
//  Project_Weather
//
//  Created by inooph on 2021/08/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier: String = "cell"
    var countries: [Country] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "countries") else { return }
        
        do {
            self.countries = try jsonDecoder.decode([Country].self, from: dataAsset.data)
        } catch {
            showAlert(error)
        }
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cityListVC = segue.destination as? CityListViewController else { return }
        
        guard let cell = sender as? ContryTableViewCell else { return }
        cityListVC.stringForViewTitle = cell.countryNameLabel.text

        guard let index = tableView.indexPathForSelectedRow?.row else { return }
        let country = countries[index]
        cityListVC.tmpCountry = country
        
        print("\(String(describing: cityListVC.tmpCountry?.contName))") // 네비게이션 타이틀 설정 -> '한국'
    }
    
    private func showAlert(_ error: Error?) {
        let allertController: UIAlertController = UIAlertController(title: "알림", message: error?.localizedDescription, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        allertController.addAction(okAction)
        present(allertController, animated: true, completion: nil)
    }
}

// MARK: - [ㅇ] UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ContryTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ContryTableViewCell else { return UITableViewCell() }
        let country: Country = countries[indexPath.row]
        cell.update(country)
        
        return cell
    }
}
