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
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.posterImageView.image = self.posterLargeImage
        }
        // Do any additional setup after loading the view.
    }
}
