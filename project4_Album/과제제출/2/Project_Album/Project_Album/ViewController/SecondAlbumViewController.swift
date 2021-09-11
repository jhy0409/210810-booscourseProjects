//
//  SecondAlbumViewController.swift
//  Project_Album
//
//  Created by inooph on 2021/09/01.
//

import UIKit
import Photos
class SecondAlbumViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - [ㅇ] 변수선언
    var assets: PHFetchResult<PHAsset>
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - [ㅇ] 변수 - 툴바
    @IBOutlet weak var toolbar: UIToolbar!
    var isTappedBarItem: Bool = false
    var isTapped_tmp: Bool = false // 셀 선택 가능 여부
    var sortRecentPhoto: UIBarButtonItem?
    var shareItem: UIBarButtonItem?
    var deleteItem: UIBarButtonItem?
    
    // MARK: - [ㅇ] 변수 - 사진 다중선택
    @IBOutlet weak var multiSelectPhoto_BarButtonItem: UIBarButtonItem!
    static var tappedMultiSelect: Bool?
    var selectedCells : [PHAsset] = []
    var selectedIndexPathArr: [IndexPath]?
    var orgTitle: String?
    let selectPhotoTitle: String = "항목 선택"
    var countNum: Int?
    
    // MARK: - [ㅇ] 동작 : 선택 누를 때
    @IBAction func multiSelect(_ sender: Any) {
        print("\n1. multiSelect Function : \(String(describing: SecondAlbumViewController.tappedMultiSelect))")
        if SecondAlbumViewController.tappedMultiSelect == true {
            SecondAlbumViewController.tappedMultiSelect = false
            
            collectionView.allowsMultipleSelection = false
            multiSelectPhoto_BarButtonItem.title = "선택"
            self.title = orgTitle
            
            selectedCells.removeAll()
            collectionView.reloadItems(at: [IndexPath(indexes: 0...0)])
            print("\n\n 🥶🥶 multiSelect - collectionView.reloadItems")
            barItemStatusChange(SecondAlbumViewController.tappedMultiSelect)
            deselectTotalCell(collectionView, didSelectItemAt: selectedIndexPathArr)
        } else {
            SecondAlbumViewController.tappedMultiSelect = true
            collectionView.allowsMultipleSelection = true
            multiSelectPhoto_BarButtonItem.title = "취소"
            self.title = selectPhotoTitle
            barItemStatusChange(SecondAlbumViewController.tappedMultiSelect)
        }
        print("2. multiSelect Function : \(String(describing: SecondAlbumViewController.tappedMultiSelect))")
    }
    
    // MARK: - [ㅇ] 공유, 삭제 활성화(바 버튼아이템)
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
    
    func makeThirdVC(_ sender: Any) {
        guard let thirdVC = self.storyboard?.instantiateViewController(identifier: "thirdView") as? ThirdDetailPhoto_ViewController else { return }
        
        guard let index = sender as? IndexPath else { return }
        thirdVC.asset = assets[index.item]
        
        let date: (String, String) = makeDate(assets[index.item]) ?? ("NONE", "NONE")
        thirdVC.dateString = date
        self.navigationController?.pushViewController(thirdVC, animated: true)
    }
    
    // MARK: - [ㅇ] 셀 동작 - 선택취소
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let tmpMulti: Bool? = SecondAlbumViewController.tappedMultiSelect
        print("\n---> 🟢 tmpMulti: \(String(describing: tmpMulti)) / isTappedBarItem: \(isTappedBarItem)/ isTapped_tmp: \(isTapped_tmp)")
        
        if selectedCells.count >= 1, tmpMulti == true { // 셀즈 어레이에서 생성날짜와 같은 이미지 찾기
            let exceptIndexPathPhoto = selectedCells.filter { resultAsset in
                assets[indexPath.item] != resultAsset
            }
            selectedCells = exceptIndexPathPhoto
            self.title = selectedCells.count >= 1 ? "\(selectedCells.count)개 선택" : selectPhotoTitle
        } else {
            self.title = orgTitle
        }
        
        barItemStatusChange(SecondAlbumViewController.tappedMultiSelect)
        print("---> 🟢 didDeselectItemAt - selectedCells.count : \(selectedCells.count)")
    }
    
    // MARK: - [ㅇ] 셀 동작 - 선택
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let tmpMulti: Bool = SecondAlbumViewController.tappedMultiSelect else { makeThirdVC(indexPath); return }
        print("\n---> 🟠 tmpMulti: \(tmpMulti) / isTappedBarItem: \(isTappedBarItem)/ isTapped_tmp: \(isTapped_tmp)")
        
        if (tmpMulti == true && isTappedBarItem == false && isTapped_tmp == true) ||
            (tmpMulti == true && isTappedBarItem == false && isTapped_tmp == false) {
            self.selectedCells.append(assets[indexPath.item])
            self.title = "\(selectedCells.count)개 선택"
            selectedIndexPathArr?.append(indexPath)
        }
        
        if tmpMulti == false {
            makeThirdVC(indexPath)
        }
        barItemStatusChange(tmpMulti)
        print("---> 🟠 didSelectItemAt - selectedCells.count : \(selectedCells.count)")
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
            sortPhoto()
        }
        let size: CGSize = CGSize(width: asset.pixelWidth, height: asset.pixelHeight)
        imageManager.requestImage(for: assets[indexPath.item], targetSize:
            size, contentMode: .aspectFit, options: nil) { image, _  in
            cell.photoImgView.image = image
        }
        return cell
    }
    
    // MARK: - [ㅇ] 뷰 초기값 세팅
    override func viewDidLoad() {
        super.viewDidLoad()
        PHPhotoLibrary.shared().register(self)
        setToolBarItem_SetAlignment()
        print("🟡🟡 secondVC 🟡🟡 didload : \(assets.count) 🌹🌹")
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
        print("🟢🟢 secondVC 🟢🟢 tappedMultiSelect : \(String(describing: SecondAlbumViewController.tappedMultiSelect))")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) line 30 - required init?(coder: NSCoder)")
    }
    
    init?(assets: PHFetchResult<PHAsset>, title: String, coder: NSCoder) {
        self.assets = assets
        print("\n🟠🟠 secondVC 🟠🟠 required init? - assets : \(assets.count) 🍀🍀")
        super.init(coder: coder)
        self.title = title
        orgTitle = title
    }
    
    // MARK: - [ㅇ] 툴바 아이템 중앙정렬
    func setToolBarItem_SetAlignment() {
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 0).isActive = true
        toolbar.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 0).isActive = true
        toolbar.trailingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.trailingAnchor, multiplier: 0).isActive = true
        
        var items: [UIBarButtonItem] = []
        let emptySpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        let titleStr: String = isTappedBarItem == true ? "최신순" : "과거순"
        let sortRecentPhoto = UIBarButtonItem(title: titleStr, style: .plain, target: self, action: #selector(sortPhoto))
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
    
    // MARK: - [ㅇ] 사진 삭제
    @objc func deletePhotos() {
        print("\n\n---> 👹func deletePhotos()")
        // 1. 선택한만큼 지운다.
        for i in selectedCells {
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.deleteAssets([i] as NSFastEnumeration)
            }, completionHandler: nil)
        }
        // 2. 다 지웠을 때
        if selectedCells.count == 0 {
            self.selectedCells.removeAll()
            self.setTitle()
        } else {
            self.selectedCells.removeAll()
            deselectTotalCell(collectionView, didSelectItemAt: selectedIndexPathArr)
            self.setTitle()
            collectionView.reloadItems(at: [IndexPath(indexes: 0...0)])
        }
        self.barItemStatusChange(SecondAlbumViewController.tappedMultiSelect)
    }
    
    // MARK: - [ㅇ] 선택 사진(phasset) array -> 이미지 배열로
    func getImages(_ phassets: [PHAsset]) -> [UIImage] {
        let manager = PHImageManager.default()
        var shareImages: [UIImage] = []
        let option = PHImageRequestOptions()
        
        for i in phassets {
            var img = UIImage()
            manager.requestImage(for: i, targetSize: CGSize(width: i.pixelWidth, height: i.pixelHeight), contentMode: .aspectFit, options: option) { resultImg, info in
                img = resultImg!
            }
            shareImages.append(img)
        }
        return shareImages
    }
    
    // MARK: - [ㅇ] 공유 창 띄우기
    @objc func sharePhotos() {
        print("func sharePhotos()")
        if selectedCells.count > 0 {
            let shareItem = getImages(selectedCells)
            shareOutSideUsingActivityVC(shareItem)
            print("🔵 secondVC 🔵 func sharePhotos() - shareItem.count : \(shareItem.count)")
        }
    }
    
    func shareOutSideUsingActivityVC(_ images: [UIImage]) {
        print("--> 🔵🔵 secondVC 🔵🔵 shareOutSideUsingActivityVC ")
        let activityPhotos: [UIImage] = images
        
        let activityVC = UIActivityViewController(activityItems: activityPhotos, applicationActivities: nil)
        self.present(activityVC, animated: true) {
            self.selectedCells.removeAll()
            self.deselectTotalCell(self.collectionView, didSelectItemAt: self.selectedIndexPathArr)
            self.barItemStatusChange(SecondAlbumViewController.tappedMultiSelect)
            self.setTitle()
        }
    }
    
    // MARK: - [ㅇ] 네비게이션 타이틀 설정
    func setTitle() {
        print("\n\n--> 🌻 func setTitle()")
        guard let tmpMulti = SecondAlbumViewController.tappedMultiSelect else { return }
        if self.selectedCells.count >= 1, tmpMulti == true {
            self.title = self.selectedCells.count >= 1 ? "\(self.selectedCells.count)개 선택" : self.selectPhotoTitle
        } else if tmpMulti == true {
            self.title = self.selectPhotoTitle
        }
        else {
            self.title = self.orgTitle
        }
    }
    
    // MARK: - [ㅇ] 사진 정렬
    @objc func sortPhoto() {
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
        sortPHAsset(isTappedBarItem)
        collectionView.allowsMultipleSelection = isTappedBarItem
    }
    
    func sortPHAsset(_ isTapped: Bool) {
        let fetchOptions = PHFetchOptions()
        if isTapped == true {
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        } else {
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        }
        print("\n--> 🔵🔵 secondVC 🔵🔵 sortPHAsset / assets.count : \(assets.count)")
        if orgTitle == "Recents" {
            self.assets = PHAsset.fetchAssets(with: fetchOptions)
        } else {
            //self.assets = PHAsset.fetchAssets(with: fetchOptions)
        }
        collectionView.reloadItems(at: [IndexPath(indexes: 0...0)])
        print("--> 🔵🔵 secondVC 🔵🔵🔵 sortPHAsset / collectionView.reloadItems / assets.count : \(assets.count)")
    }
}

// MARK: - [ㅇ] 셀 사이즈
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
            print("\n--> 🟣🟣 secondVC 🟣🟣 main.addOperation - reloadItems")
        }
    }
    
    // MARK: - [ㅇ] 3번째 뷰 제목 만들기 makeDate
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
    
    // MARK: - [ㅇ] 전체 셀 선택 해제
    func deselectTotalCell(_ collectionView: UICollectionView, didSelectItemAt indexPath: [IndexPath]?) {
        guard let index = indexPath else { return }
        for i in index {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                            SecondCollectionViewCell.reuseIdentifier, for: i) as? SecondCollectionViewCell else { return }
            cell.isSelected = false
        }
    }
}
