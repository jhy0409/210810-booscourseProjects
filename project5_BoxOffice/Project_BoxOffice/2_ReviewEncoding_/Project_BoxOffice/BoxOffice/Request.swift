//
//  Request.swift
//  BoxOffice
//
//  Created by inooph on 2021/09/08.
//

import Foundation
import UIKit

let recieveMovieID: String = "DidRecieveMovies"
let DidRecievedMoviesNotification: Notification.Name = Notification.Name(recieveMovieID)
let recieveMovieComments: String = "DidRecieveMovieComments"
let MovieCommentsNotification: Notification.Name = Notification.Name(recieveMovieComments)
let shared = MovieShared.shared


// MARK: - [] 🔴
func requestMovies(_ commentsByID: String, _ completion: ((Data?, URLResponse?, Error?)->())?) {
    print("삐에로 1 - func requestMovies")
    guard let url: URL = appendSubQueryForComments(commentsByID) else { return }
    print("url : \(url)")
    let session: URLSession = URLSession(configuration: .default)
    let dataTask: URLSessionDataTask = session.dataTask(with: url) { (data: Data?, urlResponse: URLResponse?, error: Error?) in
        guard let data = data else { return }
        do {
            let apiResponse: MovieComments =  try JSONDecoder().decode(MovieComments.self, from: data)
            NotificationCenter.default.post(name: MovieCommentsNotification, object: nil, userInfo: ["movieComments":apiResponse, "comments":apiResponse.comments])
            shared.movieComments = apiResponse
            shared.movieComments?.comments = apiResponse.comments
        } catch let err {
            print("\n\n---> 🤡 Request.swift / err.localizedDescription : \(err.localizedDescription)")
            //alertNetworking(err)
            completion?(data, urlResponse, err)
        }
    }
    dataTask.resume()
}

func requestMovies(movieID: String, _ completion: ((Data?, URLResponse?, Error?)->())?) {
    print("삐에로 2 - func requestMovies")
    guard let url: URL = appendSubQueryByMovieID(movieID) else { return }
    let session: URLSession = URLSession(configuration: .default)
    let dataTask: URLSessionDataTask = session.dataTask(with: url) { (data: Data?, urlResponse: URLResponse?, error: Error?) in
        guard let data = data else { return }
        do {
            let apiResponse: MovieDetail =  try JSONDecoder().decode(MovieDetail.self, from: data)
            NotificationCenter.default.post(name: DidRecievedMoviesNotification, object: nil, userInfo: ["detail":apiResponse])
        } catch let err {
            print("\n\n---> 🤡🤡 Request.swift / err.localizedDescription : \(err.localizedDescription)")
            completion?(data, urlResponse, err)
        }
    }
    dataTask.resume()
}

//    let testURL: String = "https://connect-boxoffice.run.goorm.io/"
func requestMoovies(_ sortType: SortType?) {
    let testURL: String = "https://connect-boxoffice.run.goorm.io/movies"
    guard let sort = sortType else { return }
    guard let url: URL = appendSubQueryBySortType(testURL, sort) else { return }
    let session: URLSession = URLSession(configuration: .default)
    let dataTask: URLSessionDataTask = session.dataTask(with: url) { (data: Data?, urlResponse: URLResponse?, error: Error?) in
        guard let data = data else { return }
        do {
            let apiResponse: MovieList =  try JSONDecoder().decode(MovieList.self, from: data)
            NotificationCenter.default.post(name: DidRecievedMoviesNotification, object: nil, userInfo: ["movies":apiResponse.movies, "movieList":apiResponse])
        } catch let err {
            print("\n\n---> 🤮🤮 Request.swift / err.localizedDescription : \(err.localizedDescription)")
        }
    }
    dataTask.resume()
}

func getViewTitleFromSortType(_ sort: SortType) -> String {
    var resultString: String = ""
    switch sort {
    case .reservation:
        resultString = "예매율"
        
    case .curation:
        resultString = "큐레이션"
        
    case .openingDate:
        resultString = "개봉일"
    }
    
    return resultString
}

//connect-boxoffice.run.goorm.io/movies?order_type=1
// MARK: - [ㅇ] URL 서브쿼리 메소드 - 영화정렬 순서
func appendSubQueryBySortType(_ inputURL: String, _ sort: SortType) -> URL? {
    var resultURLString = inputURL + "?order_type="
    
    switch sort { //영화 정렬순서
    case .reservation:
        resultURLString.append("0") //0: 예매율(default)
    case .curation:
        resultURLString.append("1") //1: 큐레이션
    case .openingDate:
        resultURLString.append("2") //2: 개봉일
    }
    guard let url: URL = URL(string: resultURLString) else { return nil }
    
    return url
}

// MARK: - [ㅇ] URL 서브쿼리 메소드 - 영화세부정보, for thirdViewController
func appendSubQueryByMovieID(_ id: String) -> URL? {
    let testURL: String = "https://connect-boxoffice.run.goorm.io/movie"
    let resultURLString = testURL + "?id=\(id)"
    guard let url: URL = URL(string: resultURLString) else { return nil }
    return url
}

func appendSubQueryForComments(_ id: String) -> URL? {
    let testURL: String = "https://connect-boxoffice.run.goorm.io/comments?movie_id="
    let resultURLString = testURL + "\(id)"
    guard let url: URL = URL(string: resultURLString) else { return nil }
    return url
}

//func alertNetworking(_ error: Error?) {
//    guard let error = error else { return }
//    let errorDescription: String = error.localizedDescription
//    let alert = UIAlertController(title: "알림", message: errorDescription, preferredStyle: .alert)
//    let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
//}
