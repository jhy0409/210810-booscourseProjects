//
//  FirstCollectionViewCell.swift
//  Project_Album
//
//  Created by inooph on 2021/08/31.
//

import UIKit

class FirstCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgView_thumbnail: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photoCountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgView_thumbnail.layer.cornerRadius = 10
        imgView_thumbnail.clipsToBounds = true
    }
}
