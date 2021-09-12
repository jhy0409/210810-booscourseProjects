//
//  SecondCollectionViewCell.swift
//  BoxOffice
//
//  Created by inooph on 2021/09/09.
//

import UIKit

class SecondCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var RatingAndReservationLabel: UILabel!
    @IBOutlet weak var openDateLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var gradeImageView: UIImageView!
    
    func update(_ movie: Movie) {
        movieTitleLabel.text = movie.title
        RatingAndReservationLabel.text = movie.descriptionOfRating.1
        openDateLabel.text = movie.openingdate
        gradeImageView.image = movie.gradeIcon
    }
}
