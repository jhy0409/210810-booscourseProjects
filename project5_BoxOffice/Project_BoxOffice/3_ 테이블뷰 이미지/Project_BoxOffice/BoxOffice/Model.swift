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
    let order_type: SortType
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
    
    var descriptionOfRating: String {
        return "평점 : \(user_rating) | 예매순위 : \(reservation_grade) | 예매율 : \(reservation_rate)"
    }
    
    var openingdate: String {
        return "개봉일 : \(date)"
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

// MARK: - [ㅇ] 영화 정렬순서 / 0: 예매율(default), 1: 큐레이션, 2: 개봉일
enum SortType: Int, Codable {
    case reservation, curation, openingDate
}

class MovieShared {
    static var shared = MovieShared()
    var movieList: MovieList? = nil
    
    private init() { }
}
