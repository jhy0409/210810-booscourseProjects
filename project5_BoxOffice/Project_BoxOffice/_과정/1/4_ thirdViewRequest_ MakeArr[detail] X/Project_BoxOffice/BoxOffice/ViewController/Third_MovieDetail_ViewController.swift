//
//  Third_MovieDetail_ViewController.swift
//  BoxOffice
//
//  Created by inooph on 2021/09/09.
//

import UIKit

class Third_MovieDetail_ViewController: UIViewController {
    let firstCell: String = "thirdOfFirst"
    var urlFromSecondView: URL?
    var movie: Movie?
    
    
    
    let shared = MovieShared.shared
    let movieDetailArr: [MovieDetail]? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = .white
//        notiAddObserber()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        movie = nil
    }
    
//    @objc func didRiecieveMovieNotification(_ noti: Notification) {
//        guard let movieDetail: MovieDetail = noti.userInfo?["detail"] as? MovieDetail else { return }
//        shared.movieDetail = movieDetail
        
//        DispatchQueue.main.async {
//            //self.tableView.reloadData()
//            // MARK: - [ㅇ] 뷰타이틀 세팅 - 앱 초기진입
//            guard let sort = self.shared.movieList?.order_type else { return }
//            self.title = getViewTitleFromSortType(sort)
//        }
//    }
    
//    func notiAddObserber() {
//        NotificationCenter.default.addObserver(self, selector: #selector(didRiecieveMovieNotification(_:)), name: DidRecievedMoviesNotification, object: nil)
//    }
}


extension Third_MovieDetail_ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell: ThirdOfFirst_MovieIntro_TableViewCell = tableView.dequeueReusableCell(withIdentifier: firstCell) as? ThirdOfFirst_MovieIntro_TableViewCell, let sendMovie = shared.movieDetail, let movie = movie else { return UITableViewCell() }
        
        
        guard let cell: ThirdOfFirst_MovieIntro_TableViewCell = tableView.dequeueReusableCell(withIdentifier: firstCell) as? ThirdOfFirst_MovieIntro_TableViewCell, let movie = movie else { return UITableViewCell() }
        let movieDetailArr = shared.movieDetailArr
        let detail = movieDetailArr.first { movieD in return movie.id == movieD.id }
        guard let detail = detail else { return cell }
        cell.update(detail)
        cell.posterImageView.image = movie.posterImage
        
        return cell
    }
}
