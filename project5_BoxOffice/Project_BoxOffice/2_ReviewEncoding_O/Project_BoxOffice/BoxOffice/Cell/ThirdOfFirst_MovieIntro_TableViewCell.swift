//
//  ThirdOfFirst_MovieIntro_TableViewCell.swift
//  BoxOffice
//
//  Created by inooph on 2021/09/09.
//

import UIKit

class ThirdOfFirst_MovieIntro_TableViewCell: UITableViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var openingDateLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!
    @IBOutlet weak var gradeImageView: UIImageView!
    
    @IBOutlet weak var reservationRateLabel: UILabel!
    @IBOutlet weak var userRateLabel: UILabel!
    @IBOutlet weak var audienceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func update(_ movieDetail: MovieDetail) {
        movieTitleLabel.text = movieDetail.title
        openingDateLabel.text = "\(movieDetail.date) 개봉"
        movieGenreLabel.text = movieDetail.genreAndDuration
        gradeImageView.image = movieDetail.gradeIcon
        reservationRateLabel.text = "\(movieDetail.reserveRankAndRate)"
        userRateLabel.attributedText = movieDetail.rateStar
        audienceLabel.text = decimalAudience(movieDetail.audience)
    }
    
    func decimalAudience(_ number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let result = numberFormatter.string(from: NSNumber(value: number)) else { return ""}
        return result
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

