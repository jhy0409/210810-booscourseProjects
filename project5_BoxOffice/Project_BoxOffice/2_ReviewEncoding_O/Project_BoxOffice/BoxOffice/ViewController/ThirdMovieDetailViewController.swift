//
//  ThirdMovieDetailViewController.swift
//  BoxOffice
//
//  Created by inooph on 2021/09/09.
//

import UIKit

class ThirdMovieDetailViewController: UIViewController,UITableViewDelegate {
    // MARK: - [ㅇ] 변수 - 셀 및 뷰 구분자
    let firstCell: String = "thirdOfFirst"
    let secondCell: String = "thirdOfSecond"
    let thirdCell: String = "thirdOfThird"
    let fourthCell: String = "thirdOfFourth"
    let fourthView: String = "fourthView"
    let posterView: String = "posterView"
    
    // MARK: - [ㅇ] 변수 - 영화정보
    var urlFromSecondView: URL?
    let shared = MovieShared.shared
    var movie: Movie?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    let sectionForTableView: [String] = ["movieDetail", "synopsis", "directAndActor", "comments"]
    var commentArr: [Comment]?
    var tapGesture: UITapGestureRecognizer?
    
    // MARK: - [ㅇ] view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bringSubviewToFront(indicator)
        indicatorShow(false, indicator)
        
        self.navigationController?.navigationBar.tintColor = .white
        notiAddObserberDetail()
        notiAddObserberComments()
        refresh()
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(posterImageViewTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.tableView.sectionHeaderHeight = CGFloat.leastNormalMagnitude
            self.tableView.reloadSections(IndexSet(0...3), with: .automatic)
            self.view.layoutIfNeeded()
            print("\n\n---> 👀👀👀 thirdView super.viewWillAppear(")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        indicatorShow(animated, indicator)
    }
    
    // MARK: - [ㅇ] 포스터이미지 크게 보기
    @objc func posterImageViewTapped() {
        guard let posterView = self.storyboard?.instantiateViewController(identifier: posterView) as? PosterViewController else { return }
        guard let movie = self.movie, let imageString = shared.movieDetail?.image else { return }
        posterView.title = movie.title + " 포스터 이미지"
        posterView.movie = movie
        
        DispatchQueue.main.async {
            guard let imageURL = URL(string: imageString), let imageData = try? Data(contentsOf: imageURL), let posterImage: UIImage = UIImage(data: imageData) else { return }
            posterView.posterLargeImage = posterImage
        }
        navigationController?.pushViewController(posterView, animated: true)
    }
    
    // MARK: - [ㅇ] 뷰 당겨서 데이터 갱신 - view refresh
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
    
    
    // MARK: - [ㅇ] 노티 등록, notification
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
            self.commentArr = comments
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

// MARK: - [ㅇ] 테이블별 셀 세팅 - tableViewCell data setting
extension ThirdMovieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3, let comments = commentArr {
            return comments.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sendMovie = shared.movieDetail, let movie = movie else { return UITableViewCell() }
        switch indexPath.section {
        
        case 0: //movieDetail
            guard let cell: ThirdOfFirstMovieIntroTableViewCell = tableView.dequeueReusableCell(withIdentifier: firstCell) as? ThirdOfFirstMovieIntroTableViewCell else { return UITableViewCell() }
            guard let tapGestureForcell = tapGesture else { return cell }
            cell.posterImageView.image = movie.posterImage
            cell.posterImageView.addGestureRecognizer(tapGestureForcell)
            cell.posterImageView.isUserInteractionEnabled = true
            DispatchQueue.main.async {
                cell.update(sendMovie)
            }
            return cell
            
        case 1: // synopsis
            guard let cell: ThirdOfSecondMovieIntroTableViewCell = tableView.dequeueReusableCell(withIdentifier: secondCell) as? ThirdOfSecondMovieIntroTableViewCell else { return UITableViewCell() }
            cell.update(sendMovie)
            return cell
            
        case 2: // directAndActor
            guard let cell: ThirdOfThirdDirectorAndActorTableViewCell = tableView.dequeueReusableCell(withIdentifier: thirdCell) as? ThirdOfThirdDirectorAndActorTableViewCell else { return UITableViewCell() }
            cell.update(sendMovie)
            return cell
            
        case 3: // comments
            guard let cell: ThirdOfFourthMovieIntroTableViewCell = tableView.dequeueReusableCell(withIdentifier: fourthCell) as? ThirdOfFourthMovieIntroTableViewCell else { return UITableViewCell() }
            guard let comment: Comment = commentArr?[indexPath.row] else { return cell }
            
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
extension ThirdMovieDetailViewController {
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
            
            header.addSubview(button)
            header.backgroundColor = .systemGray6
            return header
        } else {
            return nil
        }
    }
    
    // MARK: - [ㅇ] 리뷰 작성뷰 띄우기 
    @objc func commentViewPush() {
        guard let fourthViewAsReview = self.storyboard?.instantiateViewController(identifier: fourthView) as? FourthReviewViewController else { return }
        guard let movie = self.movie else { return }
        fourthViewAsReview.title = "한줄평 작성"
        fourthViewAsReview.movie = movie
        fourthViewAsReview.callbackResult = {
            print("\n\n\n---> 🟢 thirdView 🟢 fourthVC.callbackResult = ")
            indicatorShow(false, self.indicator)
            requestMovies(movie.id) {data, response, error in
                self.alertNetworking(data, response, error)
            }
            self.tableView.reloadData()
            self.tableView.reloadSections(IndexSet(0...3), with: .automatic)
            indicatorShow(true, self.indicator)
        }
        self.navigationController?.pushViewController(fourthViewAsReview, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section < 3 {
            return 1
        }
        return 70
    }
    
    private func alertNetworking(_ data: Data?, _ response: URLResponse? , _ error: Error?) {
        print("🟢 3rdVC - alert 🟢 func alertNetworking(_ error: Error?)")
        guard let error = error else { return }
        let errorDescription: String = error.localizedDescription
        let alert = UIAlertController(title: "알림", message: errorDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
