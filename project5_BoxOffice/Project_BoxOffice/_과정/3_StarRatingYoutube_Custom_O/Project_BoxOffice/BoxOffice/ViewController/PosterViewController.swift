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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
