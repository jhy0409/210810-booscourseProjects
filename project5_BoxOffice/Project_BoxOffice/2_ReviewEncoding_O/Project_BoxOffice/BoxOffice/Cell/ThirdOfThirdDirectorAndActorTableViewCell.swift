//
//  ThirdOfThirdDirectorAndActorTableViewCell.swift
//  BoxOffice
//
//  Created by inooph on 2021/09/10.
//

import UIKit

class ThirdOfThirdDirectorAndActorTableViewCell: UITableViewCell {
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var actorLabel: UILabel!
    
    func update(_ movieDetail: MovieDetail) {
        directorLabel.text = movieDetail.director
        actorLabel.text = movieDetail.actor
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
