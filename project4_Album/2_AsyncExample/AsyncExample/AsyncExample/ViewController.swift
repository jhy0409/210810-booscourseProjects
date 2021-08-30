//
//  ViewController.swift
//  AsyncExample
//
//  Created by inooph on 2021/08/30.
//

import UIKit
// 백그라운드 : 큰데이터 다운 및 처리
// 메인스레드 : 결과 화면에 표현
class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func touchUpDownloadButton(_ sender: UIButton) {
        // 이미지 다운로드 -> 이미지 뷰에 셋팅
        // https://upload.wikimedia.org/wikipedia/commons/3/3d/LARGE_elevation.jpg
        
        guard let imageURL: URL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/3/3d/LARGE_elevation.jpg") else { return }
        
        OperationQueue().addOperation {
            let imageData: Data = try! Data.init(contentsOf: imageURL)
            let image: UIImage = UIImage(data: imageData)!
            
            OperationQueue.main.addOperation {
                self.imageView.image = image
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

