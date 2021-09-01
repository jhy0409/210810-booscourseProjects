//
//  SecondAlbumViewController.swift
//  Project_Album
//
//  Created by inooph on 2021/09/01.
//

import UIKit
import Photos
class SecondAlbumViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    /*
     화면 2 - 앨범내 사진 목록
      
     [화면구성]
     - [ㅇ] 내비게이션 아이템의 타이틀은 이전 화면에서 선택된 앨범 이름입니다.
     - [ㅇ] 컬렉션뷰의 이미지뷰는 정사각형으로, 내부 이미지는 기존 이미지 비율을 유지합니다.
     - [ㅇ] 화면 하단에는 사진 정렬 방법을 선택하기 위한 툴바가 있습니다.
     
     [기능]
     - [] 사진 다중 선택 기능
        - [] 내비게이션 바의 '선택' 버튼을 누르면 버튼의 타이틀이 '취소'로, 내비게이션 아이템의 타이틀이 '항목 선택'으로 바뀝니다.
        - [] 컬렉션뷰 셀(사진)을 선택하면 선택된 사진의 윤곽선과 투명도가 변해 선택되었음을 나타냅니다.
        - [] 선택된 사진 장수가 내비게이션 아이템의 타이틀에 즉각 반영됩니다.
        - [] '취소' 버튼을 누르면 선택된 사진이 해제되고 초기 상태로 되돌아갑니다.
     
     - [ㅇ] 사진 정렬 기능(사진 날짜 기준)
        - [ㅇ] 초기 설정은 최신 사진이 제일 위에 오는 정렬입니다.
        - [ㅇ] 툴바의 버튼을 누르면 최신순/과거순 토글로 사진의 순서가 바뀝니다.
        - [ㅇ] 툴바의 버튼을 누르면 현재 상태에 따라 버튼의 타이틀이 변경됩니다.
     
     - [] 공유 기능
        - [] 공유 버튼은 기본적으로 비활성화되어있습니다.
        - [] 사진이 선택 모드에 들어가 선택된 사진이 1장 이상일 때만 활성화됩니다.
        - [] 선택된 사진을 이미지로 공유하는 창을 띄웁니다.
     
     - [] 삭제 기능
        - [] 삭제 버튼은 기본적으로 비활성화되어있습니다.
        - [] 사진이 선택 모드에 들어가 선택된 사진이 1장 이상일 때만 활성화됩니다.
        - [] 이미지 선택 후 활성화된 버튼을 탭하면 선택된 사진을 삭제합니다.
     
     - [] 컬렉션뷰 셀을 선택하면 화면3으로 전환됩니다.
     */
    var assets: PHFetchResult<PHAsset>
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    
    @IBOutlet weak var toolbar: UIToolbar!
    var isTappedBarItem: Bool = true
    var testBarItem: UIBarButtonItem?
    @IBOutlet weak var collectionView: UICollectionView!
    
    var phAssetArr: [PHAsset] = []
    var countNum: Int?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                SecondCollectionViewCell.reuseIdentifier, for: indexPath)
                as? SecondCollectionViewCell else { return UICollectionViewCell() }
        
        let asset = assets[indexPath.item]
        // MARK: - 사진 하나씩 붙임
        if countNum == nil {
            self.phAssetArr.append(asset)
        }
        
        imageManager.requestImage(for: phAssetArr[indexPath.item], targetSize: cell.photoImgView.bounds.size, contentMode: .aspectFill, options: nil) { image, _  in
            cell.photoImgView.image = image
        }
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PHPhotoLibrary.shared().register(self)
        // Do any additional setup after loading the view.
        setToolBarItem_SetAlignment()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) line 30 - required init?(coder: NSCoder)")
    }
    
    init?(assets: PHFetchResult<PHAsset>, title: String, coder: NSCoder) {
        self.assets = assets
        super.init(coder: coder)
        self.title = title
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: - 툴바 아이템 중앙정렬
    func setToolBarItem_SetAlignment() {
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 0).isActive = true
        toolbar.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 0).isActive = true
        toolbar.trailingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.trailingAnchor, multiplier: 0).isActive = true
        
        var items: [UIBarButtonItem] = []
        let emptySpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        let titleStr: String = isTappedBarItem == true ? "최신순" : "과거순"
        let sortRecentPhoto = UIBarButtonItem(title: titleStr, style: .plain, target: self, action: #selector(sortPhotos))
        items.append(emptySpace)
        items.append(sortRecentPhoto)
        items.append(emptySpace)
        toolbar.setItems(items, animated: true)
        
        testBarItem = sortRecentPhoto
    }
    
    @objc func sortPhotos() {
        countNum = 1
        if isTappedBarItem == true {
            testBarItem?.title = "과거순"
            isTappedBarItem = false
        } else {
            testBarItem?.title = "최신순"
            isTappedBarItem = true
        }
        sortPhoto(isTappedBarItem)
    }
    
    func sortPhoto(_ isTapped: Bool) {
        let tmpArr = phAssetArr.sorted(by: { ph1, ph2 in
            if let ph1Date = ph1.creationDate, let ph2Date = ph2.creationDate {
                print("날짜비교 되었음 ")
                
                if isTapped == true {
                    print("---> 과거순")
                    return ph1Date < ph2Date
                } else {
                    print("---> 최신순")
                    return ph1Date > ph2Date
                }
            }
            else {
                print("픽셀 비교 되었음")
                return ph1.pixelWidth < ph2.pixelWidth
            }
        })
        phAssetArr = tmpArr
        collectionView.reloadItems(at: [IndexPath(indexes: 0...0)])
        
        print("\n\n---> 🟡 sortPhotoOld / phAssetArr.count : \(phAssetArr.count)")
    }
}

// MARK: - 셀 사이즈
extension SecondAlbumViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 10
        let margin: CGFloat = 20
        let width: CGFloat = (collectionView.bounds.width - (itemSpacing * 2) - (margin * 2)) / 3
        
        let size: CGSize = CGSize(width: width, height: width)
        return size
    }
}

extension SecondAlbumViewController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        print(" 작성하기 - func photoLibraryDidChange(_ changeInstance: PHChange) ")
    }
}

