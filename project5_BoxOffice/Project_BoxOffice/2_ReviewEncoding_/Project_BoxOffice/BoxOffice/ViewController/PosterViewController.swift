//
//  PosterViewController.swift
//  BoxOffice
//
//  Created by inooph on 2021/09/12.
//

import UIKit

class PosterViewController: UIViewController {
    let storyBoardIdentifire: String = "posterView"
    @IBOutlet weak var posterImageView: UIImageView!
    var movie: Movie?
    var posterLargeImage: UIImage?
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicatorShow(false, self.indicator)
        DispatchQueue.main.async {
            self.posterImageView.image = self.posterLargeImage
            indicatorShow(true, self.indicator)
        }
    }
}
