//
//  FirstViewController.swift
//  ProjectC_WeatherToday
//
//  Created by 김광준 on 2019/11/28.
//  Copyright © 2019 VincentGeranium. All rights reserved.
//

import UIKit
// MARK: - MainViewController
/// 화면 1 부분 -> 국가 목록
class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - mainTableView
    /// MainViewController의 tableView
    private var mainTableView: UITableView = {
        var tableView: UITableView = UITableView()
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.cellIdentifier)
        return tableView
    }()
    
    // MARK: - flagImage
    /// mainTableView에 들어가는 국가별 국기 데이터
    private let flagImage: FlagImageData = {
        let flagImage: FlagImageData = FlagImageData()
        return flagImage
    }()
    
    let mainVCTitle: String = "세계 날씨"
    
    // MARK: - countryList
    var countryList: [Country] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        self.title = mainVCTitle
        
        decodeCountryData()
        setupNaviController(self: self)
        setupMainTableView()
    }
    
    // MARK: - setupMainTableView
    private func setupMainTableView() {
        
        let guide = self.view.safeAreaLayoutGuide
        
        self.view.addSubview(mainTableView)
        
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: guide.topAnchor),
            mainTableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
        ])
    }
    
    // MARK: - numberOfSections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: - tableView(_, numberOfRowsInSection)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countryList.count
    }
    
    // MARK: - tableView(_, cellForRowAt)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.cellIdentifier, for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
                
        let country: Country = self.countryList[indexPath.row]
        
        cell.mainLabel.text = country.koreanName
        
        getFlagImage(cell: cell, country: country)
        
        return cell
    }
    
    // MARK: - tableView(_, didSelectRowAt)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.cellIdentifier, for: indexPath) as? MainTableViewCell else {
            return
        }
        
        if indexPath.row == 0 && cell.isSelected == false {
            let koreaVC = KoreaViewController()
            navigationController?.pushViewController(koreaVC, animated: true)
        } else if indexPath.row == 1 && cell.isSelected == false {
            let germanyVC = GermanyViewController()
            navigationController?.pushViewController(germanyVC, animated: true)
        } else if indexPath.row == 2 && cell.isSelected == false {
            let italyVC = ItalyViewController()
            navigationController?.pushViewController(italyVC, animated: true)
        } else if indexPath.row == 3 && cell.isSelected == false {
            let usaVC = USAViewController()
            navigationController?.pushViewController(usaVC, animated: true)
        } else if indexPath.row == 4 && cell.isSelected == false {
            let franceVC = FranceViewController()
            navigationController?.pushViewController(franceVC, animated: true)
        } else if indexPath.row == 5 && cell.isSelected == false {
            let japanVC = JapanViewController()
            navigationController?.pushViewController(japanVC, animated: true)
        }
    }
    
    
    // MARK: - getFlagImage(cell, country)
    private func getFlagImage(cell: MainTableViewCell, country: Country) {
        if country.koreanName == "한국" {
            cell.mainImageView.image = flagImage.koreaFlag
        } else if country.koreanName == "독일" {
            cell.mainImageView.image = flagImage.germanyFlag
        } else if country.koreanName == "이탈리아" {
            cell.mainImageView.image = flagImage.italyFlag
        } else if country.koreanName == "미국" {
            cell.mainImageView.image = flagImage.usaFlag
        } else if country.koreanName == "프랑스" {
            cell.mainImageView.image = flagImage.franceFlag
        } else if country.koreanName == "일본" {
            cell.mainImageView.image = flagImage.japanFlag
        }
    }
    
    // MARK: - decodeCountryData
    private func decodeCountryData() {
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "countries") else {
            return
        }
        
        do {
            self.countryList = try jsonDecoder.decode([Country].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
}
