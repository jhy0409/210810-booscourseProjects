//
//  ViewController.swift
//  BoxOffice
//
//  Created by inooph on 2021/09/08.
//

import UIKit

class First_MovieList_ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var movies: [Movie] = []
    var movieList: MovieList?
    let cellIdentifier: String = "firstCell"
    
    let recieveMovieID: String = "DidRecieveMovies"
    lazy var DidRecievedMoviesNotification: Notification.Name = Notification.Name(recieveMovieID)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: FirstTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? FirstTableViewCell else { return UITableViewCell() }
        
        guard let movie = self.movies[indexPath.row] as? Movie else { return cell }
        cell.update(movie)
        DispatchQueue.global().async {
            guard let imageURL: URL = URL(string: movie.thumb) else { return }
            guard let imageData: Data = try? Data(contentsOf: imageURL) else { return }

            DispatchQueue.main.async {
                if let index: IndexPath = tableView.indexPath(for: cell) {
                    if index.row == indexPath.row {
                        cell.posterImageView.backgroundColor = .systemBackground
                        cell.posterImageView.image = UIImage(data: imageData)
                    } else {
                        cell.posterImageView.image = nil
                        cell.posterImageView.backgroundColor = .gray
                    }
                }
            }
        }
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notiAddObserber()
    }
    
    @objc func didRiecieveMovieNotification(_ noti: Notification) {
        guard let movies: [Movie] = noti.userInfo?["movies"] as? [Movie] else { return }
        guard let movieList: MovieList = noti.userInfo?["movieList"] as? MovieList else { return }
        self.movies = movies
        self.movieList = movieList
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            // MARK: - [ㅇ] 뷰타이틀 세팅 - 앱 초기진입
            guard let sort = self.movieList?.order_type else { return }
            self.title = getViewTitleFromSortType(sort)
        }
    }
    
    
    func notiAddObserber() {
        NotificationCenter.default.addObserver(self, selector: #selector(didRiecieveMovieNotification(_:)), name: DidRecievedMoviesNotification, object: nil)
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        requestMoovies(SortType.reservation)
    }
    
    @IBAction func tappedSortingButton(_ sender: Any) {
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
        reservationAction = UIAlertAction(title: "예매율", style: .default, handler: { alertAction in sortType = .reservation; print("🟢 sortType: \(sortType)"); requestMoovies(sortType); self.title = getViewTitleFromSortType(sortType)})
        
        let curationAction: UIAlertAction
        curationAction = UIAlertAction(title: "큐레이션", style: .default, handler: { alertAction in sortType = .curation; print("🟢 sortType: \(sortType)"); requestMoovies(sortType); self.title = getViewTitleFromSortType(sortType)})
        
        let openingDateAction: UIAlertAction
        openingDateAction = UIAlertAction(title: "개봉일", style: .default, handler: { alertAction in sortType = .openingDate; print("🟢 sortType: \(sortType)"); requestMoovies(sortType); self.title = getViewTitleFromSortType(sortType)})
        
        let cancelAction: UIAlertAction
        cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alertController.addAction(reservationAction)
        alertController.addAction(curationAction)
        alertController.addAction(openingDateAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

