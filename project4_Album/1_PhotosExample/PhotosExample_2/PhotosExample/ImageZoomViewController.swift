//
//  ImageZoomViewController.swift
//  PhotosExample
//
//  Created by inooph on 2021/08/30.
//

import UIKit
import Photos

class ImageZoomViewController: UIViewController, UIScrollViewDelegate {
    var asset: PHAsset!
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    
    @IBOutlet weak var imageView: UIImageView!
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let options = PHImageRequestOptions()
        options.resizeMode = .exact
        imageManager.requestImage(for: asset,
                                  targetSize: CGSize(
                                    width: asset.pixelWidth,
                                    height: asset.pixelHeight),
                                  contentMode: .aspectFill,
                                  options: options,
                                  resultHandler: { image, _ in
                                    self.imageView.image = image
                                  })
    }
}
