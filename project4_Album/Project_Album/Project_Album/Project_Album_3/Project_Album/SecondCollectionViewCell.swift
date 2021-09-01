//
//  SecondCollectionViewCell.swift
//  Project_Album
//
//  Created by inooph on 2021/09/01.
//

import UIKit

class SecondCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "cell"
    @IBOutlet weak var photoImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoImgView.layer.cornerRadius = 10
        photoImgView.clipsToBounds = true
        photoImgView.layer.borderWidth = 0.5
        photoImgView.layer.borderColor = CGColor.init(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    }
}
