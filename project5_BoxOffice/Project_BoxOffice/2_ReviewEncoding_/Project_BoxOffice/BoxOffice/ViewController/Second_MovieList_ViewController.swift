//
//  Second_MovieList_ViewController.swift
//  BoxOffice
//
//  Created by inooph on 2021/09/09.
//

import UIKit

class Second_MovieList_ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private let cellIdentifire = "secondCell"
    let shared = MovieShared.shared
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    // MARK: - [ㅇ] view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        notiAddObserber()
        refresh()
        self.view.bringSubviewToFront(indicator)
        indicator.isHidden = false
        indicator.startAnimating()
        guard let sort = self.shared.movieList?.order_type else { return }
        self.title = getViewTitleFromSortType(sort)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        indicator.stopAnimating()
        indicator.isHidden = true
    }
    
    // MARK: - [ㅇ] 노티 등록, notification
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
    
    private func alertNetworking(_ data: Data?, _ response: URLResponse? , _ error: Error?) {
        print("🤮 SecondVC - alert2 🤮 func alertNetworking(_ error: Error?)")
        guard let error = error else { return }
        let errorDescription: String = error.localizedDescription
        let alert = UIAlertController(title: "알림", message: errorDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - [ㅇ] UICollectionViewDelegateFlowLayout
extension Second_MovieList_ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 10
        let margin: CGFloat = 20
        let width: CGFloat = (collectionView.bounds.width - (margin * 2) - itemSpacing) / 2
        let height: CGFloat = width * 2
        return CGSize(width: width, height: height)
    }
}

// MARK: - [ㅇ] UICollectionViewDelegate
extension Second_MovieList_ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movies: [Movie] = shared.movieList?.movies else { return }
        let movie = movies[indexPath.item]
        guard let thirdViewController = storyboard?.instantiateViewController(identifier: "thirdVC") as? Third_MovieDetail_ViewController else { return }
        
        thirdViewController.urlFromSecondView = appendSubQueryByMovieID(movie.id)
        thirdViewController.movie = movie
        requestMovies(movieID: movie.id) {data,response,error in
            self.alertNetworking(data, response, error)
        }
        requestMovies(movie.id) {data,response,error in
            self.alertNetworking(data, response, error)
        }
        thirdViewController.title = "\(movie.title)"
        self.navigationController?.pushViewController(thirdViewController, animated: true)
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
        DispatchQueue.main.async {
            cell.posterImageView.image = movie.posterImage
        }
        return cell
    }
}
