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
    var size: CGFloat? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        guard let size = size else { return }
        posterImageView.frame.size = CGSize(width: size, height: size + 100 )
        // Initialization code
    }

    func update(_ movieDetail: MovieDetail) {
//        posterImageView.image = movie.posterImage
        movieTitleLabel.text = movieDetail.title
        openingDateLabel.text = movieDetail.date
        movieGenreLabel.text = movieDetail.genre
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
