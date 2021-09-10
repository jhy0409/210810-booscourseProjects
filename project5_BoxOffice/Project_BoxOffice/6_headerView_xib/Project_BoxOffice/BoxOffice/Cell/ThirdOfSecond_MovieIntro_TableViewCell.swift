//
//  ThirdOfFirst_MovieIntro_TableViewCell.swift
//  BoxOffice
//
//  Created by inooph on 2021/09/09.
//

import UIKit

class ThirdOfSecond_MovieIntro_TableViewCell: UITableViewCell {
    @IBOutlet weak var synopsisLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func update(_ movieDetail: MovieDetail) {
        synopsisLabel.text = movieDetail.synopsis
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

