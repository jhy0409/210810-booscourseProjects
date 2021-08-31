//
//  ViewController.swift
//  Project_Album
//
//  Created by inooph on 2021/08/31.
//

import UIKit
import Photos

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, PHPhotoLibraryChangeObserver {
    
    /*
     [화면 1 - 앨범 목록]
     
     [화면구성]
     - [ㅇ] 내비게이션 아이템 타이틀은 "앨범" 입니다.
     - [] 컬렉션뷰를 이용해 앨범의 대표 이미지를 보여줍니다.
        - [ㅇ/] 컬렉션뷰의 이미지는 정사각형 모양으로, 내부의 이미지는 기존 이미지 비율을 유지합니다.
        - [/] 앨범의 대표 이미지는 해당 앨범의 가장 최신 사진입니다.
        - [/] 이미지 아래 앨범 이름을 보여줍니다.
        - [/] 앨범 이름 아래 앨범에 포함된 사진의 개수를 보여줍니다.
     
     [기능]
     - [] 애플리케이션 처음 진입 시 사진 라이브러리 접근권한이 없다면 사진 라이브러리에 접근 허용 여부를 묻습니다.
        - [] 수락 시 디바이스의 사진에 접근하여 기본 앨범(카메라롤, 즐겨찾기, 셀피 등)과 사용자 커스텀 앨범을 가져옵니다.
        - [] 비수락 시 컬렉션뷰에 사진이 나타나지 않으며, 오류로 인한 애플리케이션 강제종료가 되지도 않습니다.
     - [] 컬렉션뷰 셀을 선택하면 화면2로 전환됩니다.
     */
    
    
    
    
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var fetchResult: PHFetchResult<PHAsset>!
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    let cellIdentifier: String = "cell"
    
    var tmpWidth: CGFloat?
    
    func requestCollection() {
        let cameraRoll: PHFetchResult<PHAssetCollection> =
            PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        
        guard let cameraRollCollection = cameraRoll.firstObject else { return }
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        self.fetchResult = PHAsset.fetchAssets(in: cameraRollCollection, options: fetchOptions)
    }
    
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        print("photoLibraryDidChange")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.fetchResult?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell: FirstCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? FirstCollectionViewCell else { return UICollectionViewCell()}
        
        let asset: PHAsset = fetchResult.object(at: indexPath.item)
        let options = PHImageRequestOptions()
        options.resizeMode = .exact
        
        if let tmpW: CGFloat = tmpWidth {
            imageManager.requestImage(for: asset, targetSize: CGSize(width: tmpW, height: tmpW), contentMode: .aspectFill, options: nil, resultHandler: {image, _ in cell.imgView_thumbnail.image = image})
        }
        
        
        return cell
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAuthorizationStatus {
        case .authorized:
            print("접근 허가 됨")
            self.requestCollection()
            self.collectionView.reloadData()
            
        case .denied:
            print("접근 불가")
            
        case .notDetermined:
            print("상태 - 미응답")
            PHPhotoLibrary.requestAuthorization({ (status) in
                switch status {
                case .authorized:
                    print("사용자가 허용함")
                    self.requestCollection()
                    OperationQueue.main.addOperation {
                        self.collectionView.reloadData()
                    }
                case .denied:
                    print("사용자가 불허함")
                default: break
                }
            })
        case .restricted:
            print("접근 제한")
        default:
            break
        }
        PHPhotoLibrary.shared().register(self)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 10
        let margin: CGFloat = 20
        let width = (collectionView.bounds.width - itemSpacing - margin * 2) / 2
        tmpWidth = width
        let height = width + 70
        return CGSize(width: width, height: height)
    }
}
