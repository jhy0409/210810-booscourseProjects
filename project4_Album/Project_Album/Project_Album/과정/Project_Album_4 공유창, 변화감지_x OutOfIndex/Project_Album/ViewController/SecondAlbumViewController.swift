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
     
     - [] 공유 기능
        - [ㅇ] 공유 버튼은 기본적으로 비활성화되어있습니다.
        - [ㅇ] 사진이 선택 모드에 들어가 선택된 사진이 1장 이상일 때만 활성화됩니다.
        - [] 선택된 사진을 이미지로 공유하는 창을 띄웁니다.
     
     - [] 삭제 기능
        - [ㅇ] 삭제 버튼은 기본적으로 비활성화되어있습니다.
        - [ㅇ] 사진이 선택 모드에 들어가 선택된 사진이 1장 이상일 때만 활성화됩니다.
        - [] 이미지 선택 후 활성화된 버튼을 탭하면 선택된 사진을 삭제합니다.
     
     - [] 컬렉션뷰 셀을 선택하면 화면3으로 전환됩니다.
     */
    var assets: PHFetchResult<PHAsset>
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    
    @IBOutlet weak var toolbar: UIToolbar!
    var isTappedBarItem: Bool = false
    var isTapped_tmp: Bool = false // 셀 선택 가능 여부
    var testBarItem: UIBarButtonItem?
    @IBOutlet weak var collectionView: UICollectionView!
    var phAssetArr: [PHAsset] = []
    var countNum: Int?
    static var countNumForArr: Int? = nil
    
    // MARK: - 사진 다중 선택 기능 [ㅇ]
    
    @IBOutlet weak var multiSelectPhoto_BarButtonItem: UIBarButtonItem!
    static var tappedMultiSelect: Bool?
    var selectedCells : [PHAsset] = []
    //var selectedCells : NSMutableArray = []
    //var selectedCells : [IndexPath] = []
    
    var orgTitle: String?
    let selectPhotoTitle: String = "항목 선택"
    
    // MARK: - 동작 : 선택 누를 때 [ㅇ]
    @IBAction func multiSelect(_ sender: Any) {
        //guard let tmpBool = SecondAlbumViewController.tappedMultiSelect else { return }
        
        if SecondAlbumViewController.tappedMultiSelect == true {
            SecondAlbumViewController.tappedMultiSelect = false
            collectionView.allowsMultipleSelection = false
            multiSelectPhoto_BarButtonItem.title = "선택"
            self.title = orgTitle
            
            //selectedCells.removeAllObjects()
            selectedCells.removeAll()
            collectionView.reloadItems(at: [IndexPath(indexes: 0...0)])
            setToolBarItem_SetAlignment(SecondAlbumViewController.tappedMultiSelect)
        } else {
            SecondAlbumViewController.tappedMultiSelect = true
            collectionView.allowsMultipleSelection = true
            multiSelectPhoto_BarButtonItem.title = "취소"
            self.title = selectPhotoTitle
            setToolBarItem_SetAlignment(SecondAlbumViewController.tappedMultiSelect)
        }
    }
    
    
    // MARK: - 셀 선택, 선택 취소시 동작
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let tmpMulti: Bool = SecondAlbumViewController.tappedMultiSelect else { return }
        print("\n---> 🟠 isTappedBarItem: \(isTappedBarItem)/ isTapped_tmp: \(isTapped_tmp)")
        if tmpMulti == true, isTappedBarItem == false, isTapped_tmp == true {
            //self.selectedCells.append(indexPath)
            //print("\nisTappedBarItem: \(isTappedBarItem)")
            
            
            
            //self.selectedCells.add(indexPath)
            self.selectedCells.append(assets[indexPath.item])
            self.title = "\(selectedCells.count)개 선택"
        }
        setToolBarItem_SetAlignment(tmpMulti)
        print("---> 🟠 didSelectItemAt - selectedCells.count : \(selectedCells.count)")
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        //selectedCells.remove(indexPath)
        print("\n---> 🟢 isTappedBarItem: \(isTappedBarItem)/ isTapped_tmp: \(isTapped_tmp)")
        let tmpMulti: Bool? = SecondAlbumViewController.tappedMultiSelect
        if selectedCells.count >= 1, tmpMulti == true {
            
            //selectedCells.remove(indexPath)
            //print("selectedCells : \(selectedCells.count) / indexPath.row : \(indexPath.row) / indexPath.item : \(indexPath.item)  ")
            
            //selectedCells : 2 / indexPath.row : 4 / indexPath.item : 4
            // 셀즈 어레이에서 생성날짜와 같은 이미지 찾기
            let exceptIndexPathPhoto = selectedCells.filter { resultAsset in
                assets[indexPath.item] != resultAsset
            }
            
            selectedCells = exceptIndexPathPhoto
            
            self.title = selectedCells.count >= 1 ? "\(selectedCells.count)개 선택" : selectPhotoTitle
        } else {
            self.title = orgTitle
        }
        
        setToolBarItem_SetAlignment(SecondAlbumViewController.tappedMultiSelect)
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
            self.phAssetArr.append(asset)
            
            if assets.count == phAssetArr.count {
                isTappedBarItem = true
                sortPhotos()
            }
        }
        
        
        //if selectedCells.contains(indexPath) {
        if selectedCells.contains(assets[indexPath.item]) {
            cell.isSelected = true
            //cell.photoImgView.image?.image(alpha: 0.5)
            //cell.photoImgView.layer.borderColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
            print("selectedCells.contains(indexPath) ")
        }
        
        imageManager.requestImage(for: phAssetArr[indexPath.item], targetSize: cell.photoImgView.bounds.size, contentMode: .aspectFill, options: nil) { image, _  in
            cell.photoImgView.image = image
        }
        return cell
    }
    
    override func viewDidLoad() {
        let tmpBool = false
        
        super.viewDidLoad()
        PHPhotoLibrary.shared().register(self)
        
        // Do any additional setup after loading the view.
        
        
        setToolBarItem_SetAlignment(tmpBool)
    }
    
    
    
    
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) line 30 - required init?(coder: NSCoder)")
    }
    
    init?(assets: PHFetchResult<PHAsset>, title: String, coder: NSCoder) {
        self.assets = assets
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
    func setToolBarItem_SetAlignment(_ tmpBool: Bool?) {
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
        
        if selectedCells.count >= 1, tmpBool == true {
            shareItem.isEnabled = true
            deleteItem.isEnabled = true
            sortRecentPhoto.isEnabled = false
        } else {
            shareItem.isEnabled = false
            deleteItem.isEnabled = false
            sortRecentPhoto.isEnabled = true
        }
        
        items.append(shareItem)
        items.append(emptySpace)
        items.append(sortRecentPhoto)
        items.append(emptySpace)
        items.append(deleteItem)
        toolbar.setItems(items, animated: true)
        
        testBarItem = sortRecentPhoto
    }
    
    @objc func sharePhotos() {
        print(#function)
        let shareItem = getImage(selectedCells)
        shareOutSideUsingActivityVC(shareItem)
        print("🤮 \(#function) - shareItem.count : \(shareItem.count)")
        //shareOutSideUsingActivityVC()
        
    }
    
    @objc func deletePhotos() {
        print(#function)
    }
    
    // MARK: - 선택 사진(phasset) array -> 이미지 배열로
    func getImage(_ phassets: [PHAsset]) -> [UIImage] {
        let manager = PHImageManager.default()
        var shareImages: [UIImage] = []
        
        let option = PHImageRequestOptions()

        for i in phassets {
            var img = UIImage()
            manager.requestImage(for: i, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: option) { resultImg, info in
                img = resultImg!
            }
            shareImages.append(img)
        }
        return shareImages
    }
    
    
    func shareOutSideUsingActivityVC(_ images: [UIImage]) {
        let activityPhotos: [UIImage] = images
        
        let activityVC = UIActivityViewController(activityItems: activityPhotos, applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
        //completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
        
//        { activity, success, item, error in
//            if !success {
//
//            }
            
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @objc func sortPhotos() {
        countNum = 1
        if isTappedBarItem == true {
            testBarItem?.title = "과거순"
            isTappedBarItem = false
            
            isTapped_tmp = true
        } else {
            testBarItem?.title = "최신순"
            isTappedBarItem = true
            
            isTapped_tmp = false
        }
        sortPhoto(isTappedBarItem)
        collectionView.allowsMultipleSelection = isTappedBarItem
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
        
        print("\n\n---> 🟡 sortPhoto / phAssetArr.count : \(phAssetArr.count)")
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
        //print(" 작성하기 - func photoLibraryDidChange(_ changeInstance: PHChange) ")
        
        guard let changes = changeInstance.changeDetails(for: assets) else { return }
        assets = changes.fetchResultAfterChanges
        //phAssetArr =
        OperationQueue.main.addOperation {
            //self.collectionView.reloadSections(IndexSet(0...0))
            self.collectionView.reloadItems(at: [IndexPath(indexes: 0...0)])
        }
    }
    
    
}

