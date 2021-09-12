//
//  Second_MovieList_ViewController.swift
//  BoxOffice
//
//  Created by inooph on 2021/09/09.
//

import UIKit

class Second_MovieList_ViewController: UIViewController {
    /*
     //Base URL은 https://connect-boxoffice.run.goorm.io/ 입니다.
     [화면 1 - 영화 목록]
     [화면 구성]
     - [ㅇ] 탭 인터페이스와 내비게이션 인터페이스의 결합 형태입니다.
        - [ㅇ] 첫 번째 탭은 'Table', 두 번째 탭은 'Collection' 타이틀로 구성합니다.
        - [ㅇ] 첫 번째 탭 화면은 테이블형태[ㅇ]로, 두 번째 탭 화면은 컬렉션 형태[ㅇ]로 같은 데이터를 사용하여 콘텐츠를 표시합니다.
     
        - [ㅇ] 테이블 화면
             - [ㅇ] 테이블뷰 셀에 영화 포스터를 보여줍니다.
             - [ㅇ] 포스터 오른편에 영화정보(제목ㅇ, 등급ㅇ, 평점ㅇ, 예매순위ㅇ, 예매율ㅇ, 개봉일ㅇ)를 보여줍니다.
     
        - [ㅇ] 컬렉션 화면
             - [ㅇ] 컬렉션뷰 셀에 영화 포스터와 등급을 함께 보여줍니다.
             - [ㅇ] 포스터 아래 영화정보(제목ㅇ, 평점ㅇ, 순위ㅇ, 예매율ㅇ, 개봉일ㅇ)를 보여줍니다.
     
     - [ㅇ] 내비게이션 아이템의 타이틀은 영화 정렬기준을 표시합니다.
     
     - [ㅇ] 내비게이션바 오른쪽 부분에는 내비게이션 아이템으로 바 버튼이 있습니다.
        - [ㅇ] 바 버튼은 정렬방식을 선택하기 위한 버튼입니다.
     
     [기능]
     - [ㅇ] 화면 오른쪽 상단 바 버튼을 눌러 정렬방식을 변경할 수 있습니다. (예매율/큐레이션/개봉일 기준) / 테이블[ㅇ], 콜렉션[ㅇ]
        - [ㅇ] 테이블뷰와 컬렉션뷰의 영화 정렬방식은 동일하게 적용됩니다. 즉, 한 화면에서 변경하면 다른 화면에도 변경이 적용되어 있어야 합니다.
     
     - [ㅇ] 테이블뷰와 컬렉션뷰를 아래쪽으로 잡아당기면 새로고침됩니다.
     - [] 테이블뷰/컬렉션뷰의 셀을 누르면 해당 영화의 상세 정보를 보여주는 화면 2로 전환합니다.
     */
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let cellIdentifire = "secondCell"
    let shared = MovieShared.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notiAddObserber()
        refresh()
        // Do any additional setup after loading the view.
        guard let sort = self.shared.movieList?.order_type else { return }
        self.title = getViewTitleFromSortType(sort)
    }
    
    
    
    
    
    
    
    func notiAddObserber() {
        NotificationCenter.default.addObserver(self, selector: #selector(didRiecieveMovieNotification(_:)), name: DidRecievedMoviesNotification, object: nil)
    }
    
    @objc func didRiecieveMovieNotification(_ noti: Notification) {
        guard let movies: [Movie] = noti.userInfo?["movies"] as? [Movie] else { return }
        guard let movieList: MovieList = noti.userInfo?["movieList"] as? MovieList else { return }
        
        shared.movieList?.movies = movies
        shared.movieList = movieList
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            // MARK: - [ㅇ] 뷰타이틀 세팅 - 앱 초기진입
            guard let sort = self.shared.movieList?.order_type else { return }
            self.title = getViewTitleFromSortType(sort)
        }
    }

    @IBAction func tappedSortingButton(_ sender: UIBarButtonItem) {
        let title = "정렬방식 선택"
        let message = "영화를 어떤 순서로 정렬할까요?"
        showAlert(style: .actionSheet, title: title, message: message)
    }
    
    // 0: 예매율(reservation), 1: 큐레이션(curation), 2: 개봉일(openingDate)
    // MARK: - [ㅇ] 핸들러에서 할 일 >> 정렬한 데이터로 가져오기[ㅇ], 테이블 데이터 리로드[ㅇ], 네비게이션 바 타이틀 변경[ㅇ]
    func showAlert(style: UIAlertController.Style, title: String, message: String) {
        var sortType: SortType = SortType.reservation
        let alertController: UIAlertController
        alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        let reservationAction: UIAlertAction
        reservationAction = UIAlertAction(title: "예매율", style: .default, handler: { alertAction in sortType = .reservation; print("🔵🔵 sortType: \(sortType)"); requestMoovies(sortType); self.title = getViewTitleFromSortType(sortType)})
        
        let curationAction: UIAlertAction
        curationAction = UIAlertAction(title: "큐레이션", style: .default, handler: { alertAction in sortType = .curation; print("🔵🔵 sortType: \(sortType)"); requestMoovies(sortType); self.title = getViewTitleFromSortType(sortType)})
        
        let openingDateAction: UIAlertAction
        openingDateAction = UIAlertAction(title: "개봉일", style: .default, handler: { alertAction in sortType = .openingDate; print("🔵🔵 sortType: \(sortType)"); requestMoovies(sortType); self.title = getViewTitleFromSortType(sortType)})
        
        let cancelAction: UIAlertAction
        cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alertController.addAction(reservationAction)
        alertController.addAction(curationAction)
        alertController.addAction(openingDateAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - [ㅇ] 뷰 갱신
    func refresh() {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(updateView(refresh:)), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            collectionView.refreshControl = refresh
        } else {
            collectionView.addSubview(refresh)
        }
    }
    
    @objc func updateView(refresh: UIRefreshControl) {
        refresh.endRefreshing()
        collectionView.reloadSections(NSIndexSet(index: 0) as IndexSet)
    }
}

extension Second_MovieList_ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 10
        let margin: CGFloat = 20
        let width: CGFloat = (collectionView.bounds.width - (margin * 2) - itemSpacing) / 2
        let height: CGFloat = width * 2
        return CGSize(width: width, height: height)
    }
}

// MARK: - [ㅇ] UICollectionViewDataSource
extension Second_MovieList_ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let itemsCount = shared.movieList?.movies.count else { return 0 }
        return  itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: SecondCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifire, for: indexPath) as? SecondCollectionViewCell else { return UICollectionViewCell() }
        
        guard let movie = shared.movieList?.movies[indexPath.item] else { return cell }
        cell.update(movie)
        cell.posterImageView.image = movie.posterImage
        return cell
    }
}
