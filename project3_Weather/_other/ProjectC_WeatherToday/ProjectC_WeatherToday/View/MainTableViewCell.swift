//
//  MainTableViewCell.swift
//  ProjectC_WeatherToday
//
//  Created by 김광준 on 2019/11/29.
//  Copyright © 2019 VincentGeranium. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    static let cellIdentifier: String = "MainTableViewCell"
    
    var mainImageView: UIImageView = {
        let imgView: UIImageView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    var mainLabel: UILabel = {
        let label: UILabel = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setImgViewConstraint()
        setLableConstraint()
        
        // MARK: - accessoryType
        /// 셀의 엑서사리 타입
        self.accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected == false {
            self.selectionStyle = .gray
        } else {
            self.selectionStyle = .none
        }
    }
    
    private func setImgViewConstraint() {
        contentView.addSubview(mainImageView)
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainImageView.widthAnchor.constraint(equalToConstant: 84),
        ])
    }
    
    private func setLableConstraint() {
        contentView.addSubview(mainLabel)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainLabel.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: 15),
            mainLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            mainLabel.centerYAnchor.constraint(equalTo: mainImageView.centerYAnchor),
            mainLabel.heightAnchor.constraint(equalToConstant: 54),
        ])
    }
}
