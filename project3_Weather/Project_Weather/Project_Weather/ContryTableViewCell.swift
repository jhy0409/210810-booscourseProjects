//
//  ContryTableViewCell.swift
//  Project_Weather
//
//  Created by inooph on 2021/08/26.
//

import UIKit

class ContryTableViewCell: UITableViewCell {
    @IBOutlet weak var ctryImg: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    var tmpC: Country?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func update(_ country: Country) {
        ctryImg.image = country.image
        ctryImg.layer.borderWidth = 1
        ctryImg.layer.borderColor = CGColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        countryNameLabel.text = country.contName
    }
}
