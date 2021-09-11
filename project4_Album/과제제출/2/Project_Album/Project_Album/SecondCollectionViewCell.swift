//
//  SecondCollectionViewCell.swift
//  Project_Album
//
//  Created by inooph on 2021/09/01.
//

import UIKit

class SecondCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "cell"
    var tappedMultiSelect: Bool?
    @IBOutlet weak var photoImgView: UIImageView!
    var defaultBorderColor = CGColor.init(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoImgView.layer.cornerRadius = 10
        photoImgView.clipsToBounds = true
        photoImgView.layer.borderWidth = 0.5
        photoImgView.layer.borderColor = defaultBorderColor
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected == true, tappedMultiSelect == true {
                photoImgView.alpha = 0.4
                photoImgView.layer.borderWidth = 3
                photoImgView.layer.borderColor = CGColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
            } else {
                photoImgView.layer.borderWidth = 0.5
                photoImgView.layer.borderColor = defaultBorderColor
                photoImgView.alpha = 1
            }
        }
    }
}
