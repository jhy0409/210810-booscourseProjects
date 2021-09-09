//
//  Second_MovieList_ViewController.swift
//  BoxOffice
//
//  Created by inooph on 2021/09/09.
//

import UIKit

class Second_MovieList_ViewController: UIViewController, UICollectionViewDataSource {
    /*
     //Base URL은 https://connect-boxoffice.run.goorm.io/ 입니다.
     [화면 1 - 영화 목록]
     [화면 구성]
     - [] 탭 인터페이스와 내비게이션 인터페이스의 결합 형태입니다.
        - [ㅇ] 첫 번째 탭은 'Table', 두 번째 탭은 'Collection' 타이틀로 구성합니다.
        - [] 첫 번째 탭 화면은 테이블형태[ㅇ]로, 두 번째 탭 화면은 컬렉션 형태[]로 같은 데이터를 사용하여 콘텐츠를 표시합니다.
     
        - [ㅇ] 테이블 화면
             - [ㅇ] 테이블뷰 셀에 영화 포스터를 보여줍니다.
             - [ㅇ] 포스터 오른편에 영화정보(제목ㅇ, 등급ㅇ, 평점ㅇ, 예매순위ㅇ, 예매율ㅇ, 개봉일ㅇ)를 보여줍니다.
     
        - [] 컬렉션 화면
             - [] 컬렉션뷰 셀에 영화 포스터와 등급을 함께 보여줍니다.
             - [] 포스터 아래 영화정보(제목, 평점, 순위, 예매율, 개봉일)를 보여줍니다.
     
     - [] 내비게이션 아이템의 타이틀은 영화 정렬기준을 표시합니다.
     
     - [] 내비게이션바 오른쪽 부분에는 내비게이션 아이템으로 바 버튼이 있습니다.
        - [] 바 버튼은 정렬방식을 선택하기 위한 버튼입니다.
     
     [기능]
     - [] 화면 오른쪽 상단 바 버튼을 눌러 정렬방식을 변경할 수 있습니다. (예매율/큐레이션/개봉일 기준) / 테이블[ㅇ], 콜렉션[]
        - [] 테이블뷰와 컬렉션뷰의 영화 정렬방식은 동일하게 적용됩니다. 즉, 한 화면에서 변경하면 다른 화면에도 변경이 적용되어 있어야 합니다.
     
     - [] 테이블뷰와 컬렉션뷰를 아래쪽으로 잡아당기면 새로고침됩니다.
     - [] 테이블뷰/컬렉션뷰의 셀을 누르면 해당 영화의 상세 정보를 보여주는 화면 2로 전환합니다.
     */
    
//    var movies: [Movie] = []
//    var movieList: MovieList?
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let cellIdentifire = "secondCell"
    let shared = MovieShared.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notiAddObserber()
        // Do any additional setup after loading the view.
        
        print("\n💀Second View shared.movieList?.movies.count: \(shared.movieList?.movies.count)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("\n💀💀Second View shared.movieList?.movies.count: \(shared.movieList?.movies.count)")
    }
    
    func notiAddObserber() {
        NotificationCenter.default.addObserver(self, selector: #selector(didRiecieveMovieNotification(_:)), name: DidRecievedMoviesNotification, object: nil)
    }
    
    @objc func didRiecieveMovieNotification(_ noti: Notification) {
        guard let movies: [Movie] = noti.userInfo?["movies"] as? [Movie] else { return }
        guard let movieList: MovieList = noti.userInfo?["movieList"] as? MovieList else { return }
//        self.movies = movies
//        self.movieList = movieList
        
        shared.movieList?.movies = movies
        shared.movieList = movieList
        
//        self.movies = shared.movieList?.movies as! [Movie]
//        self.movieList = shared.movieList
        
        DispatchQueue.main.async {
//            self.tableView.reloadData()
//            self.collectionView.reloadItems(at: [IndexPath(indexes: 0...0)])
            self.collectionView.reloadData()
            // MARK: - [ㅇ] 뷰타이틀 세팅 - 앱 초기진입
//            guard let sort = self.movieList?.order_type else { return }
            guard let sort = self.shared.movieList?.order_type else { return }
            self.title = getViewTitleFromSortType(sort)
        }
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        movies.count
        guard let itemsCount = shared.movieList?.movies.count else { return 0 }
        return  itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: SecondCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifire, for: indexPath) as? SecondCollectionViewCell else { return UICollectionViewCell() }
        
        //guard let movie = self.movies[indexPath.item] as? Movie else { return cell }
        guard let movie = shared.movieList?.movies[indexPath.item] as? Movie else { return cell }
        cell.update(movie)
        cell.posterImageView.image = nil
        
        DispatchQueue.global().async {
            guard let imageURL: URL = URL(string: movie.thumb) else { return }
            guard let imageData: Data = try? Data(contentsOf: imageURL) else { return }


            DispatchQueue.main.async {
                if let index: IndexPath = collectionView.indexPath(for: cell) {
                    if index.item == indexPath.item {
                        cell.posterImageView.backgroundColor = .systemBackground
                        cell.posterImageView.image = UIImage(data: imageData)
                    }
//                    else {
//                        cell.posterImageView.image = nil
//                        cell.posterImageView.backgroundColor = .gray
//                    }
                }
            }
        }
        return cell
    }

}


