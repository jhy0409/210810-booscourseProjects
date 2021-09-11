//
//  ViewController.swift
//  Project_Album
//
//  Created by inooph on 2021/08/31.
//

import UIKit
import Photos

class ViewController: UIViewController, UICollectionViewDelegate, PHPhotoLibraryChangeObserver {
    @IBOutlet weak var collectionView: UICollectionView!
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    let cellIdentifier: String = "cell"
    
    var fetchResults: [PHFetchResult<PHAsset>] = []    //앨범 정보
    var fetchCollection: [PHCollection] = []           //앨범 정보
    var fetchOptions: PHFetchOptions {                 //앨범 정보에 대한 옵션
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        return fetchOptions
    }
    
    var albumTitle: [String?] = [] // 앨범 제목
    
    func requestCollection() {
        let cameraRoll = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        let favoriteList = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumFavorites, options: nil)
        let albumList = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: nil)
        addPhotoAlbums(collection: cameraRoll)      // 스마트 앨범
        addPhotoAlbums(collection: favoriteList)    // 선호목록
        addPhotoAlbums(collection: albumList)       // 사용자 앨범
        
        OperationQueue.main.addOperation {
            self.collectionView.reloadData()
        }
    }
    
    private func addPhotoAlbums(collection : PHFetchResult<PHAssetCollection>){
        for i in 0 ..< collection.count {
            let collection = collection.object(at: i)
            self.fetchResults.append(PHAsset.fetchAssets(in: collection, options: fetchOptions))
            self.fetchCollection.append(collection)
            albumTitle.append(collection.localizedTitle) // 앨범 타이틀
        }
    }
    
    // MARK: - [ㅇ] 변경시 연동
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let changes0 = changeInstance.changeDetails(for: fetchResults[0]) else { return }
        fetchResults[0] = changes0.fetchResultAfterChanges
        guard let changes1 = changeInstance.changeDetails(for: fetchResults[1]) else { return }
        fetchResults[1] = changes1.fetchResultAfterChanges
        guard let changes2 = changeInstance.changeDetails(for: fetchResults[2]) else { return }
        fetchResults[2] = changes2.fetchResultAfterChanges
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: FirstCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? FirstCollectionViewCell else { return UICollectionViewCell()}
        
        guard let asset = fetchResults[indexPath.item].firstObject, fetchResults.count != 0 else { return cell }
        
        imageManager.requestImage(for: asset, targetSize: cell.bounds.size,
                                  contentMode: .aspectFill, options: nil) { (image, _) in
            if let index: IndexPath = collectionView.indexPath(for: cell) {
                if index.item == indexPath.item {
                    cell.imgView_thumbnail.image = image
                } else {
                    cell.imgView_thumbnail.image = nil
                }
            }
        }
        cell.update(title: albumTitle[indexPath.item], count: fetchResults[indexPath.item].count)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        // MARK: - [ㅇ] 접근권한
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("\n🥶 First ViewController")
        collectionView.reloadItems(at: [IndexPath(indexes: 0...0)])
    }
    
    // MARK: - [ㅇ] 셀 클릭 -> 두번째 뷰
    @IBSegueAction func makeSecondVC(_ coder: NSCoder) -> SecondAlbumViewController? {
        guard let selectIndex = collectionView.indexPathsForSelectedItems?.first else { return nil }
        let assets: PHFetchResult<PHAsset> =  fetchResults[selectIndex.item] // 앨범
        let title: String = albumTitle[selectIndex.item] ?? "NONE" // 앨범 타이틀
        print("-> 🟢 FirstVC 🟢 @IBSegueAction makeSecondVC: title = \(title) / assets count : \(assets.count)")
        
        let seconVC = SecondAlbumViewController(assets: assets, title: title, coder: coder)
        return seconVC
    }
}

// MARK: - [ㅇ] 셀 크기
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 10
        let margin: CGFloat = 20
        let width = (collectionView.bounds.width - itemSpacing - margin * 2) / 2
        let height = width + 70
        return CGSize(width: width, height: height)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResults.count
    }
}
