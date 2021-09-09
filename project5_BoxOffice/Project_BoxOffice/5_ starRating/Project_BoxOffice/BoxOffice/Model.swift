//
//  Model.swift
//  BoxOffice
//
//  Created by inooph on 2021/09/08.
//

import Foundation
import UIKit
// https://connect-boxoffice.run.goorm.io/movies

//{"order_type":0,"movies":[{"thumb":"http://movie.phinf.naver.net/20171201_181/1512109983114kcQVl_JPEG/movie_image.jpg?type=m99_141_2","reservation_rate":35.5,"user_rating":7.98,"date":"2017-12-20","id":"5a54c286e8a71d136fb5378e","grade":12,"reservation_grade":1,"title":"신과함께-죄와벌"},{"thumb":"http://movie.phinf.naver.net/20171102_209/1509602233507BiJrs_JPEG/movie_image.jpg?type=m99_141_2","reservation_rate":1.93,"user_rating":9.2,"date":"2017-12-07","id":"5a54df5ee8a71d136fb53d75","grade":0,"reservation_grade":8,"title":"뽀로로 극장판 공룡섬 대모험"}
//    ]
//}

// MARK: - [] Movie struct
struct MovieList: Codable {
    var order_type: SortType
    var movies: [Movie]
}





struct Movie: Codable, Hashable {
    let thumb: String
    let reservation_rate: Double
    let user_rating: Double
    let date: String
    let id: String
    let grade: Int
    let reservation_grade: Int
    let title: String
    
    var descriptionOfRating: (String, String) {
        // for table
        let table: String = "평점 : \(user_rating) | 예매순위 : \(reservation_grade) | 예매율 : \(reservation_rate)"
        
        // for collectionView
        let collection: String = "평점 : \(user_rating)\n예매순위 : \(reservation_grade)\n예매율 : \(reservation_rate)"
        return (table, collection)
    }
    
    var openingdate: String {
        return "개봉일 : \(date)"
    }

    var posterImage: UIImage {
        var resultImage = UIImage()
        guard let imageURL: URL = URL(string: thumb), let imageData: Data = try? Data(contentsOf: imageURL) else { return resultImage }
        
        resultImage = UIImage(data: imageData) ?? resultImage
        return resultImage
    }
    
    var gradeIcon: UIImage {
        var resultImage: UIImage
        var iconName: String = "ic_"
        switch grade {
        case 0:
            iconName.append("allages")
        case 12:
            iconName.append("12")
        case 15:
            iconName.append("15")
        case 19:
            iconName.append("19")
        default:
            print("\n Model - gradeIcon / [안내] 존재하지 않는 관람가입니다.")
        }
        resultImage = UIImage(named: iconName) ?? UIImage()
        
        return resultImage
    }
}

//{
//    audience: 11676822,
//    grade: 12,
//    actor: "하정우(강림), 차태현(자홍), 주지훈(해원맥), 김향기(덕춘)", duration: 139,
//    reservation_grade: 1,
//    title: "신과함께-죄와벌",
//    reservation_rate: 35.5,

//    user_rating: 7.98,
//    date: "2017-12-20",
//    director: "김용화",
//    id: "5a54c286e8a71d136fb5378e",
//    image: "http://movie.phinf.naver.net/20171201_181/1512109983114kcQVl_JPEG/movie_image.
//    jpg",
//    synopsis: "저승 법에 의하면, (중략) 고난과 맞닥뜨리는데... 누구나 가지만 아무도 본 적 없는 곳, 새 로운 세계의 문이 열린다!",
//    genre: "판타지, 드라마"
//}
     
struct MovieDetail: Codable {
    let audience: Int
    let grade: Int
    let actor: String
    let duration: Int
    let reservation_grade: Int
    let title: String
    
    let reservation_rate: Double
    let user_rating: Double
    let date: String
    let director: String
    let id: String
    
    let image: String
    let synopsis: String
    let genre: String
    
    var gradeIcon: UIImage {
        var resultImage: UIImage
        var iconName: String = "ic_"
        switch grade {
        case 0:
            iconName.append("allages")
        case 12:
            iconName.append("12")
        case 15:
            iconName.append("15")
        case 19:
            iconName.append("19")
        default:
            print("\n Model - gradeIcon / [안내] 존재하지 않는 관람가입니다.")
        }
        resultImage = UIImage(named: iconName) ?? UIImage()
        
        return resultImage
    }
    
    var genreAndDuration: String {
        return "\(genre) / \(duration)분"
    }
    
    var reserveRankAndRate: String {
        return "\(reservation_grade)위 \(reservation_rate)%"
    }
    
    var rateStar: String {
        var number = ""
        
        let count: Int = Int((user_rating/10 * 5) / 1)
        let remain: Double = 5 - ( (user_rating/10 * 5) / 1 )
        
        
        for _ in 1...count {
            number.append("⭐️")
        }
        
        for _ in 1...(5-count) {
            number.append("🌌")
        }
        
        if remain >= 0.4 {
            number.append("")
        }
        
        return number
    }
}






// MARK: - [ㅇ] 영화 정렬순서 / 0: 예매율(default), 1: 큐레이션, 2: 개봉일
enum SortType: Int, Codable {
    case reservation, curation, openingDate
}

class MovieShared {
    static var shared = MovieShared()
    var movieList: MovieList? = nil
    var movieDetail: MovieDetail? = nil
    
    private init() { }
}
