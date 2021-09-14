//
//  ThirdOfFourthMovieIntroTableViewCell.swift
//  BoxOffice
//
//  Created by inooph on 2021/09/10.
//

import UIKit

class ThirdOfFourthMovieIntroTableViewCell: UITableViewCell {
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func update(_ comment: Comment) {
        writerLabel.text = comment.writer
        ratingLabel.attributedText = comment.rateStar
        timestampLabel.text = "\(comment.writtenDate)"
        contentsLabel.text = comment.contents
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
