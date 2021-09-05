//
//  ThirdDetailPhoto_ViewController.swift
//  Project_Album
//
//  Created by inooph on 2021/09/02.
//

import UIKit
import Photos
class ThirdDetailPhoto_ViewController: UIViewController,UIScrollViewDelegate {
    /*
     [화면구성]
     - [ㅇ] 내비게이션 아이템의 타이틀은 이전 화면에서 선택된 사진 생성 일자 및 시각입니다.
     화면에 이미지뷰로 이미지를 이미지 원래의 비율대로 화면 가득 표시해줍니다.
     
     [기능]
     - [ㅇ] 즐겨찾기❤️ 기능
         - [ㅇ] 사진이 즐겨찾기 찾기 되어있는지 아닌지를 표시합니다.
         - [ㅇ] 토글 기능으로 즐겨찾기 여부를 설정할 수 있으며, 에셋에 반영하여 iOS 기본 '사진' 애플리케이션에서도 즐겨찾기 여부를 확인할 수 있습니다.
     [공유 기능]
     - [ㅇ] 현재 보이는 사진을 이미지로 공유하는 창을 띄웁니다.
     
     [삭제 기능]
     - [ㅇ] 현재 화면에 보이는 사진을 삭제하며, 에셋에 반영하여 iOS 기본 '사진' 애플리케이션에서도 삭제 여부를 확인할 수 있습니다.
     - [ㅇ] 사진을 삭제완료하면 이전 화면으로 되돌아갑니다.
     
     [사진 확대/축소 기능]
     - [ㅇ] 사진을 핀치 제스쳐를 사용하여 확대/축소할 수 있습니다.
     - [ㅇ] 사진을 터치하거나 확대/축소하면 툴바와 내비게이션바가 사라집니다.
     - [ㅇ] 다시 사진을 터치하면 툴바와 내비게이션바가 나타납니다.
     */
    
    var stoaryboardId: String = "thirdView"
    var asset: PHAsset!
    var dateString: (String, String)!
    
    @IBOutlet weak var detailImgView: UIImageView!
    @IBOutlet weak var toolbar: UIToolbar!
    
    var heartStatus: UIBarButtonItem?
    var heartEmptyIcon = UIImage(systemName: "heart")
    var heartFillIcon = UIImage(systemName: "heart.fill")
    @IBOutlet weak var scrollViewSpaceFromBottom: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImgView.image = getImage(asset)
        guard let date = dateString else { return }
        
        self.navigationItem.titleView = setTitle(title: "\(date.0)", subtitle: "\(date.1)")
        setToolBarItem_thirdVC() // 툴바 세팅
        let tapGestuer = UITapGestureRecognizer(target: self, action: #selector(imgViewTapped))
        
        detailImgView.addGestureRecognizer(tapGestuer)
        detailImgView.isUserInteractionEnabled = true
    }
    
    // MARK: - [ㅇ] 숨기기 기능(터치) ⬇️ - 툴바, 네비게이션 바
    @objc func imgViewTapped() {
            print("\n\n\n--> func imgViewTapped : 🍀🍀")
        navigationController?.setNavigationBarHidden(!toolbar.isHidden, animated: true)
        toolbar.isHidden = !toolbar.isHidden
        if toolbar.isHidden == true {
            scrollViewSpaceFromBottom.constant = 0
        } else {
            scrollViewSpaceFromBottom.constant = 49
        }
    }
    
    // MARK: - [ㅇ] 숨기기 기능(스크롤) ⬇️ - 툴바, 네비게이션 바
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        print("\n\n\n--> func scrollViewDidZoom : 🍀🍀🍀🍀")
        navigationController?.setNavigationBarHidden(true, animated: true)
        toolbar.isHidden = true
        scrollViewSpaceFromBottom.constant = 0
    }
    
    // MARK: - 삭제 기능 ⬇️
    
    @objc func deletePhoto() {
        print("\n\n--> 🟡 Did Clicked deletePhoto()")
        PHPhotoLibrary.shared().performChanges({PHAssetChangeRequest.deleteAssets([self.asset] as NSFastEnumeration)}) { resultBool, error in
            if resultBool == true {
                OperationQueue.main.addOperation {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    // MARK: - 공유 창 띄우기 ⬇️
    func shareOutSideUsingActivityVC_third(_ images: [UIImage]) {
        let activityPhotos: [UIImage] = images
        
        let activityVC = UIActivityViewController(activityItems: activityPhotos, applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @objc func sharePhoto() {
        print("\n\n--> 🔴 Did Clicked sharePhoto()")
        
        let shareItem = getImages(asset)
        shareOutSideUsingActivityVC_third(shareItem)
        print("\n\n--> 🔴🔴 Did Clicked sharePhoto() - shareItem.count : \(shareItem.count)")
    }
    
    // MARK: - 기타 메소드 ⬇️
    func getImage(_ phasset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        var resultImg = UIImage()
        
        let size = CGSize(width: phasset.pixelWidth, height: phasset.pixelHeight)
        manager.requestImage(for: phasset, targetSize: size, contentMode: .aspectFill, options: nil) { image, _  in
            if let img = image {
            resultImg = img
            }
        }
        return resultImg
    }
    
    func getImages(_ phasset: PHAsset) -> [UIImage] {
        let manager = PHImageManager.default()
        var resultImg = [UIImage]()
        
        let size = CGSize(width: phasset.pixelWidth, height: phasset.pixelHeight)
        manager.requestImage(for: phasset, targetSize: size, contentMode: .aspectFill, options: nil) { image, _  in
            if let img = image {
                resultImg.append(img)
            }
        }
        return resultImg
    }
    
    func setToolBarItem_thirdVC() {
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 0).isActive = true
        toolbar.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 0).isActive = true
        toolbar.trailingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.trailingAnchor, multiplier: 0).isActive = true
        
        var items: [UIBarButtonItem] = []
        let emptySpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)

        let shareItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharePhoto))
        let img = getHeartFromPhoto(asset.isFavorite)
        let heartStatus = UIBarButtonItem(image: img, style: .plain, target: self, action: #selector(setHeart))
        self.heartStatus = heartStatus
        
        let deleteItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deletePhoto))
        
        items.append(shareItem)
        items.append(emptySpace)
        items.append(heartStatus)
        items.append(emptySpace)
        items.append(deleteItem)
        toolbar.setItems(items, animated: true)
    }
    
    func getHeartFromPhoto(_ tmpBool: Bool) -> UIImage {
        
        var resultIcon = UIImage()
        guard let heartFill = heartFillIcon, let heartEmpty = heartEmptyIcon else { print("\n\n 🟢🟢🟢 getHeartFromPhoto Fail "); return resultIcon }
        
        switch tmpBool {
        case true:
            resultIcon = heartFill
            //print("🟢🟢 tmpBool True Area : \(tmpBool) - \(resultIcon)")
            print("🟢🟢 tmpBool True Area : \(tmpBool) - heartFill")
        default:
            resultIcon = heartEmpty
            //print("🟢🟢🟢 tmpBool nil Or false? Area : \(tmpBool)- \(resultIcon)")
            print("🟢🟢🟢 tmpBool nil Or false? Area : \(tmpBool)- heartEmpty")
        }
        return resultIcon
    }
    
    @objc func setHeart() {
        var fromAssetBool: Bool = asset.isFavorite
        print("\n\n--> 🟠 Did Clicked setHeart() - asset.isFavorite : \(fromAssetBool)")
        let change: () -> Void = {
            let request = PHAssetChangeRequest(for: self.asset)
            request.isFavorite = !fromAssetBool
        }
        
        PHPhotoLibrary.shared().performChanges(change, completionHandler: nil)
        let img = getHeartFromPhoto(!fromAssetBool)
        heartStatus?.image = img
    }
    
    // MARK: - 뷰 타이틀 제목 및 부제목
    func setTitle(title:String, subtitle:String) -> UIView {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: -2, width: 0, height: 0))

        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.text = title
        titleLabel.sizeToFit()

        let subtitleLabel = UILabel(frame: CGRect(x: 0, y: 18, width: 0, height: 0))
        subtitleLabel.backgroundColor = UIColor.clear
        subtitleLabel.textColor = UIColor.black
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        subtitleLabel.text = subtitle
        subtitleLabel.sizeToFit()

        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: max(titleLabel.frame.size.width, subtitleLabel.frame.size.width), height: 30))
        titleView.addSubview(titleLabel)
        titleView.addSubview(subtitleLabel)

        let widthDiff = subtitleLabel.frame.size.width - titleLabel.frame.size.width

        if widthDiff < 0 {
            let newX = widthDiff / 2
            subtitleLabel.frame.origin.x = abs(newX)
        } else {
            let newX = widthDiff / 2
            titleLabel.frame.origin.x = newX
        }
        return titleView
    }
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.detailImgView
    }
}
