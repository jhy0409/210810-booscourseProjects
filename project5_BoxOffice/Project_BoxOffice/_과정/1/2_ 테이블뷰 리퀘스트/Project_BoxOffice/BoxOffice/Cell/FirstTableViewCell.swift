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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if let text = movieTitleLabel.text {
            let attributedString = NSMutableAttributedString(string: text)
            
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(named: "heart")
            attributedString.append(NSAttributedString(attachment: imageAttachment))
            
            movieTitleLabel.attributedText = attributedString
        }
        
    }
    
    func update(_ movie: Movie) {
        movieTitleLabel.text = movie.title
        RatingAndReservationLabel.text = movie.descriptionOfRating
        openDateLabel.text = movie.openingdate
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
