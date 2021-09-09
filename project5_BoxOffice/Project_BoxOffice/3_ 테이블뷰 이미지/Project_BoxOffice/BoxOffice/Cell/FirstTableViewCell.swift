//
//  FirstTableViewCell.swift
//  BoxOffice
//
//  Created by inooph on 2021/09/08.
//

import UIKit

class FirstTableViewCell: UITableViewCell {
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var RatingAndReservationLabel: UILabel!
    @IBOutlet weak var openDateLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var gradeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func update(_ movie: Movie) {
        movieTitleLabel.text = movie.title
        RatingAndReservationLabel.text = movie.descriptionOfRating.0
        openDateLabel.text = movie.openingdate
        gradeImageView.image = movie.gradeIcon
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
