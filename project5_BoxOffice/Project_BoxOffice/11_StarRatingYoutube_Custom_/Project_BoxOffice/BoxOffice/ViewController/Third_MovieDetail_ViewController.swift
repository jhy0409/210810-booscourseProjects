//
//  Third_MovieDetail_ViewController.swift
//  BoxOffice
//
//  Created by inooph on 2021/09/09.
//

import UIKit
/*
 [화면 2 - 영화 상세 정보]
  
 [화면구성]
 - [ㅇ] 화면2 내비게이션 아이템 타이틀은 이전 화면에서 선택된 영화 제목입니다.
 - [ㅇ] 영화 상세정보 화면을 구현합니다.
     - [ㅇ] 영화 포스터를 포함한 소개ㅇ, 줄거리ㅇ, 감독/출연ㅇ 그리고 한줄평ㅇ을 모두 포함합니다.
     - [ㅇ] 한줄평에는 작성자의 프로필ㅇ, 닉네임ㅇ, 별점ㅇ, 작성일ㅇ 그리고 평ㅇ을 보여줍니다.
     - [ㅇ] 한줄평 오른쪽 상단에는 새로운 한줄평을 남길 수 있는 버튼이 있습니다.
 [기능]
 - [] 영화 포스터를 터치하면 포스터를 전체화면에서 볼 수 있습니다.
 - [ㅇ] 한줄평 오른쪽 상단의 새로운 한줄평 남기기 버튼을 탭하면 화면3으로 전환합니다.
 */

class Third_MovieDetail_ViewController: UIViewController,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    let firstCell: String = "thirdOfFirst"
    let secondCell: String = "thirdOfSecond"
    let thirdCell: String = "thirdOfThird"
    let fourthCell: String = "thirdOfFourth"
    let fourthView: String = "fourthView"
    
    var urlFromSecondView: URL?
    var movie: Movie?
    let shared = MovieShared.shared
    var movieComments: [Comment] = []
    
    let sectionForTableView: [String] = ["movieDetail", "synopsis", "directAndActor", "comments"]
    var commentArr: [Comment]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .white
        notiAddObserberDetail()
        notiAddObserberComments()
        refresh()
        
        indicator.startAnimating()
        tableView.sectionHeaderHeight = CGFloat.leastNormalMagnitude
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadSections(IndexSet(3...3), with: .automatic)
    }
    
    // MARK: - [] 뷰 당겨서 데이터 갱신 - view refresh
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
    
//    override func viewWillDisappear(_ animated: Bool) {
//        movie = nil
//    }
    
    // MARK: - [] 노티
    @objc func didRiecieveMovieNotification(_ noti: Notification) {
        DispatchQueue.main.async {
            guard let movieDetail: MovieDetail = noti.userInfo?["detail"] as? MovieDetail else { return }
            self.shared.movieDetail = movieDetail
            self.tableView.reloadSections(IndexSet(0...3), with: .automatic)
        }
    }
    @objc func didRecieveCommentsNotification(_ noti: Notification) {
        DispatchQueue.main.async {
            guard let commentsData: MovieComments = noti.userInfo?["movieComments"] as? MovieComments, let comments: [Comment] = noti.userInfo?["comments"] as? [Comment] else { return }
            self.shared.movieComments = commentsData
            self.shared.movieComments?.comments = comments
            self.movieComments = comments
            self.tableView.reloadSections(IndexSet(0...3), with: .automatic)
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
        }
    }
    
    func notiAddObserberDetail() {
        NotificationCenter.default.addObserver(self, selector: #selector(didRiecieveMovieNotification(_:)), name: DidRecievedMoviesNotification, object: nil)
    }
    
    func notiAddObserberComments() {
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveCommentsNotification), name: MovieCommentsNotification, object: nil)
    }
}

// MARK: - [] 테이블별 셀 세팅 - tableViewCell data setting
extension Third_MovieDetail_ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return movieComments.count
        }
        return 1
    }
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
            
        case 2: // directAndActor
            guard let cell: ThirdOfThird_DirectorAndActor_TableViewCell = tableView.dequeueReusableCell(withIdentifier: thirdCell) as? ThirdOfThird_DirectorAndActor_TableViewCell else { return UITableViewCell() }
            cell.update(sendMovie)
            return cell
            
        case 3: // comments
            guard let cell: ThirdOfFourth_MovieIntro_TableViewCell = tableView.dequeueReusableCell(withIdentifier: fourthCell) as? ThirdOfFourth_MovieIntro_TableViewCell else { return UITableViewCell() }
            guard let comment: Comment = shared.movieComments?.comments[indexPath.row] else { return cell }
            cell.update(comment)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionForTableView.count
    }
}

// MARK: - [ㅇ] 헤더뷰 세팅 - headerView setting
extension Third_MovieDetail_ViewController {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 3 {
            let frame: CGRect = tableView.frame
                    
            let header = UIView.init(frame: CGRect.init(x: 0, y: 0, width: frame.width, height: 50))
            let label = UILabel()
            let fontSize: CGFloat = 21
            let yAnchor: CGFloat = (header.frame.height - fontSize) / 2
            label.frame = CGRect.init(x: 17, y: yAnchor, width: header.frame.width-10, height: header.frame.height-10)
            label.text = "한줄평"
            label.font = .systemFont(ofSize: 21, weight: .semibold)
            label.textColor = .label
            header.addSubview(label)
            
            let button = UIButton()
            let buttonSize: CGFloat = 30
            button.frame = CGRect.init(x: header.frame.width - buttonSize - 17 , y: (header.frame.height - buttonSize), width: buttonSize, height: buttonSize)
            button.setImage(UIImage(named: "btn_compose"), for: .normal)
            button.addTarget(self, action: #selector(commentViewPush), for: .touchUpInside)

//            header.translatesAutoresizingMaskIntoConstraints = false
            header.addSubview(button)
            header.backgroundColor = .systemGray6
            return header
        } else {
            return nil
        }
    }
    
    @objc func commentViewPush() {
        guard let fourthViewAsReview = self.storyboard?.instantiateViewController(identifier: fourthView) as? FourthReviewViewController else { return }
        guard let movie = self.movie else { return }
        fourthViewAsReview.title = "한줄평 작성"
        fourthViewAsReview.movie = movie
        self.navigationController?.pushViewController(fourthViewAsReview, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section < 3 {
            return 1
        }
        return 70
    }
}
