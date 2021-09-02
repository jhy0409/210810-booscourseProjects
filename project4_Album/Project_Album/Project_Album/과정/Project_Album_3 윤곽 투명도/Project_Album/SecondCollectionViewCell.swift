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
    var orgImg: UIImage?
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
            if isSelected {
                photoImgView.layer.borderWidth = 3
                photoImgView.layer.borderColor = CGColor.init(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
                
                let tmpImg = photoImgView.image?.alpha(1)
                orgImg = tmpImg
                
                let img = photoImgView.image?.alpha(0.4)
                photoImgView.image = img
                
            } else {
                photoImgView.layer.borderWidth = 0.5
                photoImgView.layer.borderColor = defaultBorderColor
                photoImgView.image = orgImg
            }
        }
    }
}

extension UIImage {
    
    func alpha(_ value: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: value)
        
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
