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
     - [ㅇ] 사진 다중 선택 기능
        - [ㅇ] 내비게이션 바의 '선택' 버튼을 누르면 버튼의 타이틀이 '취소'로, 내비게이션 아이템의 타이틀이 '항목 선택'으로 바뀝니다.
        - [ㅇ] 컬렉션뷰 셀(사진)을 선택하면 선택된 사진의 윤곽선과 투명도가 변해 선택되었음을 나타냅니다.
        - [ㅇ] 선택된 사진 장수가 내비게이션 아이템의 타이틀에 즉각 반영됩니다.
        - [ㅇ] '취소' 버튼을 누르면 선택된 사진이 해제되고 초기 상태로 되돌아갑니다.
     
     - [ㅇ] 사진 정렬 기능(사진 날짜 기준)
        - [ㅇ] 초기 설정은 최신 사진이 제일 위에 오는 정렬입니다.
        - [ㅇ] 툴바의 버튼을 누르면 최신순/과거순 토글로 사진의 순서가 바뀝니다.
        - [ㅇ] 툴바의 버튼을 누르면 현재 상태에 따라 버튼의 타이틀이 변경됩니다.
     
     - [ㅇ] 공유 기능
        - [ㅇ] 공유 버튼은 기본적으로 비활성화되어있습니다.
        - [ㅇ] 사진이 선택 모드에 들어가 선택된 사진이 1장 이상일 때만 활성화됩니다.
        - [ㅇ] 선택된 사진을 이미지로 공유하는 창을 띄웁니다.
     
     - [] 삭제 기능
        - [ㅇ] 삭제 버튼은 기본적으로 비활성화되어있습니다.
        - [ㅇ] 사진이 선택 모드에 들어가 선택된 사진이 1장 이상일 때만 활성화됩니다.
        - [] 이미지 선택 후 활성화된 버튼을 탭하면 선택된 사진을 삭제합니다.
     
     - [ㅇ] 컬렉션뷰 셀을 선택하면 화면3으로 전환됩니다.
     */
    static var recieveAsset: PHFetchResult<PHAsset>?
    static var recieveCollection: PHCollection?
    
    
    var assets: PHFetchResult<PHAsset>
    //var cllt: PHFetchResult<PHCollection>?
    var assetTTT: PHAssetCollection?
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    
    @IBOutlet weak var toolbar: UIToolbar!
    var isTappedBarItem: Bool = false
    var isTapped_tmp: Bool = false // 셀 선택 가능 여부
    
    var sortRecentPhoto: UIBarButtonItem?
    var shareItem: UIBarButtonItem?
    var deleteItem: UIBarButtonItem?
    
    @IBOutlet weak var collectionView: UICollectionView!
    var phAssetArr: [PHAsset] = []
    var countNum: Int?
    static var countNumForArr: Int? = nil
    
    // MARK: - 사진 다중 선택 기능 [ㅇ]
    
    @IBOutlet weak var multiSelectPhoto_BarButtonItem: UIBarButtonItem!
    static var tappedMultiSelect: Bool?
    var selectedCells : [PHAsset] = []
    
    var orgTitle: String?
    let selectPhotoTitle: String = "항목 선택"
    var selectedIndexPathArr: [IndexPath]?
    
    
    
    //var thirdViewController = UIViewController()
    
    
    
    // MARK: - 동작 : 선택 누를 때 [ㅇ]
    @IBAction func multiSelect(_ sender: Any) {
        //guard let tmpBool = SecondAlbumViewController.tappedMultiSelect else { return }
        print("\n1. multiSelect Function : \(SecondAlbumViewController.tappedMultiSelect)")
        if SecondAlbumViewController.tappedMultiSelect == true {
            SecondAlbumViewController.tappedMultiSelect = false
            
//            isTappedBarItem = true
//            isTapped_tmp = true // 셀 선택 가능 여부
            collectionView.allowsMultipleSelection = false
            multiSelectPhoto_BarButtonItem.title = "선택"
            self.title = orgTitle
            
            selectedCells.removeAll()
            collectionView.reloadItems(at: [IndexPath(indexes: 0...0)])
            barItemStatusChange(SecondAlbumViewController.tappedMultiSelect)
            deselectTotalCell(collectionView, didSelectItemAt: selectedIndexPathArr)
        } else {
            SecondAlbumViewController.tappedMultiSelect = true
//            isTappedBarItem = false
//            isTapped_tmp = false // 셀 선택 가능 여부
            collectionView.allowsMultipleSelection = true
            multiSelectPhoto_BarButtonItem.title = "취소"
            self.title = selectPhotoTitle
            barItemStatusChange(SecondAlbumViewController.tappedMultiSelect)
        }
        print("2. multiSelect Function : \(SecondAlbumViewController.tappedMultiSelect)")
    }
    
    // MARK: - 공유, 삭제 활성화(바 버튼아이템)
    func barItemStatusChange(_ tmpBool: Bool?) {
        if selectedCells.count >= 1, tmpBool == true {
            self.shareItem?.isEnabled = true
            self.deleteItem?.isEnabled = true
            self.sortRecentPhoto?.isEnabled = false
            
        } else if selectedCells.count == 0, tmpBool == true {
            self.shareItem?.isEnabled = false
            self.deleteItem?.isEnabled = false
            self.sortRecentPhoto?.isEnabled = false
            
        } else {
            self.shareItem?.isEnabled = false
            self.deleteItem?.isEnabled = false
            self.sortRecentPhoto?.isEnabled = true
        }
    }
    
//    var fromSecondViewImg: UIImage?
    // MARK: - 셀 선택, 선택 취소시 동작
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
//                SecondCollectionViewCell.reuseIdentifier, for: indexPath)
//                as? SecondCollectionViewCell else { return }
        
//        let asset = assets[indexPath.item]
//        fromSecondViewImg = getImage(asset)
        
        guard let tmpMulti: Bool = SecondAlbumViewController.tappedMultiSelect else { makeThirdVC(indexPath); return }
        print("\n---> 🟠 tmpMulti: \(tmpMulti) / isTappedBarItem: \(isTappedBarItem)/ isTapped_tmp: \(isTapped_tmp)")
        
        if (tmpMulti == true && isTappedBarItem == false && isTapped_tmp == true) ||
            (tmpMulti == true && isTappedBarItem == false && isTapped_tmp == false) {
            self.selectedCells.append(assets[indexPath.item])
            self.title = "\(selectedCells.count)개 선택"
            
            selectedIndexPathArr?.append(indexPath)
        }
        
        if tmpMulti == false || tmpMulti == nil {
            makeThirdVC(indexPath)
        }
        barItemStatusChange(tmpMulti)
        print("---> 🟠 didSelectItemAt - selectedCells.count : \(selectedCells.count)")
    }
    
    func makeThirdVC(_ sender: Any) {
        //, let img = fromSecondViewImg
        guard let thirdVC = self.storyboard?.instantiateViewController(identifier: "thirdView") as? ThirdDetailPhoto_ViewController else { return }
        
        guard let index = sender as? IndexPath else { return }
        
        print("---> 🟠🟠 세번째 뷰 생성 중 : \(thirdVC == nil)")
        
        thirdVC.asset = assets[index.item]
        
        let date: (String, String) = makeDate(assets[index.item]) ?? ("NONE", "NONE")
        //        let tmpStr: String = "\(date.0) -- \(date.1)"
        //        thirdVC.title = tmpStr
        thirdVC.dateString = date
        self.navigationController?.pushViewController(thirdVC, animated: true)
    }
    
    func makeDate(_ phasset: PHAsset) -> (String, String)? {
        guard let date = phasset.creationDate else { return nil }
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-M-d"
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "H:m:s"
        
        let str1 = dateFormatter1.string(from: date)
        let str2 = dateFormatter2.string(from: date)
        return (str1, str2)
    }
    
    func deselectTotalCell(_ collectionView: UICollectionView, didSelectItemAt indexPath: [IndexPath]?) {
        guard let index = indexPath else { return }
        for i in index {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                    SecondCollectionViewCell.reuseIdentifier, for: i)
                    as? SecondCollectionViewCell else { return }
            cell.isSelected = false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let tmpMulti: Bool? = SecondAlbumViewController.tappedMultiSelect
//        guard let thirdVC = self.storyboard?.instantiateViewController(identifier: "thirdView") else { return }
        print("\n---> 🟢 tmpMulti: \(tmpMulti) / isTappedBarItem: \(isTappedBarItem)/ isTapped_tmp: \(isTapped_tmp)")
        
        if selectedCells.count >= 1, tmpMulti == true {
            // 셀즈 어레이에서 생성날짜와 같은 이미지 찾기
            let exceptIndexPathPhoto = selectedCells.filter { resultAsset in
                assets[indexPath.item] != resultAsset
            }
            selectedCells = exceptIndexPathPhoto
            self.title = selectedCells.count >= 1 ? "\(selectedCells.count)개 선택" : selectPhotoTitle
        } else {
//            print("---> 🟢🟢 세번째 뷰 생성 중 : \(thirdVC == nil)")
            self.title = orgTitle
        }
        
        
        barItemStatusChange(SecondAlbumViewController.tappedMultiSelect)
        print("---> 🟢 didDeselectItemAt - selectedCells.count : \(selectedCells.count)")
    }
    
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
            isTappedBarItem = true
            sortPhotos()
        }
        
        imageManager.requestImage(for: assets[indexPath.item], targetSize: cell.photoImgView.bounds.size, contentMode: .aspectFill, options: nil) { image, _  in
            cell.photoImgView.image = image
        }
        return cell
    }
    
    override func viewDidLoad() {
        //let tmpBool = false
        super.viewDidLoad()
        PHPhotoLibrary.shared().register(self)
        
        setToolBarItem_SetAlignment()
        
        guard let rcvAsset = SecondAlbumViewController.recieveAsset else { return }
        assets = rcvAsset
        //assetTTT = assets
        print("🌹🌹 second view didload : \(assets.count) / 🌹recieveCollection : \(SecondAlbumViewController.recieveCollection)🌹🌹")
        // Do any additional setup after loading the view.
        
        
        //guard let thirdVC = self.storyboard?.instantiateViewController(identifier: "thirdView") else { return }
        //self.thirdViewController = thirdVC
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isTappedBarItem = false
        isTapped_tmp = false
        SecondAlbumViewController.tappedMultiSelect = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        isTappedBarItem = false
        isTapped_tmp = false
        print("SecondAlbumViewController.tappedMultiSelect : \(SecondAlbumViewController.tappedMultiSelect)")
//        if self.countNum == 1 {
//            SecondAlbumViewController.tappedMultiSelect = true
//        } else {
//            SecondAlbumViewController.tappedMultiSelect = nil
//        }
        
        print("😈😈😈😈😈")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) line 30 - required init?(coder: NSCoder)")
    }
    
    init?(assets: PHFetchResult<PHAsset>, title: String, coder: NSCoder) {
        self.assets = assets
        print("\n🍀🍀 required init? - assets : \(assets.count) 🍀🍀")
        super.init(coder: coder)
        self.title = title
        orgTitle = title
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: - 툴바 아이템 중앙정렬 [ㅇ]
    func setToolBarItem_SetAlignment() {
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 0).isActive = true
        toolbar.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 0).isActive = true
        toolbar.trailingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.trailingAnchor, multiplier: 0).isActive = true
        
        var items: [UIBarButtonItem] = []
        let emptySpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)

        let titleStr: String = isTappedBarItem == true ? "최신순" : "과거순"
        let sortRecentPhoto = UIBarButtonItem(title: titleStr, style: .plain, target: self, action: #selector(sortPhotos))
        let shareItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharePhotos))
        let deleteItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deletePhotos))
        
        items.append(shareItem)
        items.append(emptySpace)
        items.append(sortRecentPhoto)
        items.append(emptySpace)
        items.append(deleteItem)
        toolbar.setItems(items, animated: true)
        
        self.sortRecentPhoto = sortRecentPhoto
        self.shareItem = shareItem
        self.deleteItem = deleteItem
        barItemStatusChange(SecondAlbumViewController.tappedMultiSelect)
    }
    
    @objc func sharePhotos() {
        print(#function)
        let shareItem = getImages(selectedCells)
        shareOutSideUsingActivityVC(shareItem)
        print("🔵 \(#function) - shareItem.count : \(shareItem.count)")
    }
    
    // MARK: - 사진 삭제
    @objc func deletePhotos() {
        print(#function)
        
        //selectedCell
        //assets
        
//        selectedCells
//        assets
    }
    
    
    
    
    
    // MARK: - 선택 사진(phasset) array -> 이미지 배열로
    func getImages(_ phassets: [PHAsset]) -> [UIImage] {
        let manager = PHImageManager.default()
        var shareImages: [UIImage] = []
        
        let option = PHImageRequestOptions()

        for i in phassets {
            var img = UIImage()
            manager.requestImage(for: i, targetSize: CGSize(width: i.pixelWidth, height: i.pixelHeight), contentMode: .aspectFill, options: option) { resultImg, info in
                img = resultImg!
            }
            shareImages.append(img)
        }
        return shareImages
    }
    
    
    func getImage0(_ phasset: PHAsset) -> UIImage {
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
    
    // MARK: - 공유 창 띄우기
    func shareOutSideUsingActivityVC(_ images: [UIImage]) {
        let activityPhotos: [UIImage] = images
        
        let activityVC = UIActivityViewController(activityItems: activityPhotos, applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @objc func sortPhotos() {
        countNum = 1
        if isTappedBarItem == true {
            self.sortRecentPhoto?.title = "과거순"
            isTappedBarItem = false
            isTapped_tmp = true
        } else {
            self.sortRecentPhoto?.title = "최신순"
            isTappedBarItem = true
            isTapped_tmp = false
        }
        sortPhoto(isTappedBarItem)
        collectionView.allowsMultipleSelection = isTappedBarItem
    }
    
    func sortPhoto(_ isTapped: Bool) {
        
        let fetchOptions = PHFetchOptions()
        if isTapped == true {
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        } else {
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        }
        print("\n---> 🟡 sortPhoto / assets.count : \(assets.count)")
        if orgTitle == "Recents" {
            self.assets = PHAsset.fetchAssets(with: fetchOptions)
        } else {
        }
        
        collectionView.reloadItems(at: [IndexPath(indexes: 0...0)])

        print("---> 🟡🟡 sortPhoto / assets.count : \(assets.count)")
    }
}

// MARK: - 셀 사이즈 [ㅇ]
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
        
        guard let changes = changeInstance.changeDetails(for: assets) else { return }
        assets = changes.fetchResultAfterChanges
        OperationQueue.main.addOperation {
            self.collectionView.reloadItems(at: [IndexPath(indexes: 0...0)])
        }
    }
}








