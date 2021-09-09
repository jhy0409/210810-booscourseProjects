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
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = .white
        notiAddObserber()
        refresh()
        // Do any additional setup after loading the view.
    }
    
    func refresh() {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(updateView(refresh:)), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refresh
        } else {
            tableView.addSubview(refresh)
        }
    }
    
    @objc func updateView(refresh: UIRefreshControl) {
        refresh.endRefreshing()
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        movie = nil
    }
    
    @objc func didRiecieveMovieNotification(_ noti: Notification) {
        guard let movieDetail: MovieDetail = noti.userInfo?["detail"] as? MovieDetail else { return }
        shared.movieDetail = movieDetail
    }
    
    func notiAddObserber() {
        NotificationCenter.default.addObserver(self, selector: #selector(didRiecieveMovieNotification(_:)), name: DidRecievedMoviesNotification, object: nil)
    }
    
}


extension Third_MovieDetail_ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ThirdOfFirst_MovieIntro_TableViewCell = tableView.dequeueReusableCell(withIdentifier: firstCell) as? ThirdOfFirst_MovieIntro_TableViewCell else { return UITableViewCell() }
        
        guard let sendMovie = shared.movieDetail, let movie = movie else { return cell }
        
        cell.posterImageView.image = movie.posterImage
        DispatchQueue.main.async {
            cell.update(sendMovie)
        }
        
        return cell
    }
}
