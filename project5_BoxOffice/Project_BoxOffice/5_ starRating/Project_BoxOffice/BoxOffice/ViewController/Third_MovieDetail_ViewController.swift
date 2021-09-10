//
//  Third_MovieDetail_ViewController.swift
//  BoxOffice
//
//  Created by inooph on 2021/09/09.
//

import UIKit

class Third_MovieDetail_ViewController: UIViewController {
    /*
     
     [화면 2 - 영화 상세 정보]
      
     [화면구성]
     - [ㅇ] 화면2 내비게이션 아이템 타이틀은 이전 화면에서 선택된 영화 제목입니다.
     - [] 영화 상세정보 화면을 구현합니다.
         - [] 영화 포스터를 포함한 소개, 줄거리ㅇ, 감독/출연 그리고 한줄평을 모두 포함합니다.
         - [] 한줄평에는 작성자의 프로필, 닉네임, 별점, 작성일 그리고 평을 보여줍니다.
         - [] 한줄평 오른쪽 상단에는 새로운 한줄평을 남길 수 있는 버튼이 있습니다.
     [기능]
     - [] 영화 포스터를 터치하면 포스터를 전체화면에서 볼 수 있습니다.
     - [] 한줄평 오른쪽 상단의 새로운 한줄평 남기기 버튼을 탭하면 화면3으로 전환합니다.

     */

    
    
    let firstCell: String = "thirdOfFirst"
    let secondCell: String = "thirdOfSecond"
    let thirdCell: String = "thirdOfThird"
    
    var urlFromSecondView: URL?
    var movie: Movie?
    let shared = MovieShared.shared
    
    let sectionForTableView: [String] = ["movieDetail", "synopsis", "directAndActor", "comments"]
//    enum SectionForTableView: Int {
//        case movieDetail = 0, synopsis = 1, directAndActor, comments
//    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = .white
        notiAddObserber()
        refresh()
        // Do any additional setup after loading the view.
        
//        firstStack.frame.size.width = (tableView.bounds.width - 40) / 3
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
    
//    enum SectionForTableView {
//        case movieDetail, synopsis, directAndActor, comments
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let sendMovie = shared.movieDetail, let movie = movie else { return UITableViewCell() }
        
        switch indexPath.section {
        
        case 0: //movieDetail
            guard let cell: ThirdOfFirst_MovieIntro_TableViewCell = tableView.dequeueReusableCell(withIdentifier: firstCell) as? ThirdOfFirst_MovieIntro_TableViewCell else { return UITableViewCell() }
            
            cell.posterImageView.image = movie.posterImage
            DispatchQueue.main.async {
                cell.update(sendMovie)
            }
            return cell
            
        case 1: // synopsis
            guard let cell: ThirdOfSecond_MovieIntro_TableViewCell = tableView.dequeueReusableCell(withIdentifier: secondCell) as? ThirdOfSecond_MovieIntro_TableViewCell else { return UITableViewCell() }
            cell.update(sendMovie)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionForTableView.count
    }
}
