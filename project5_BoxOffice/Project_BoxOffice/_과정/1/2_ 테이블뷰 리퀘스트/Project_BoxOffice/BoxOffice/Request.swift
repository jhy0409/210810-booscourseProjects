//
//  Request.swift
//  BoxOffice
//
//  Created by inooph on 2021/09/08.
//

import Foundation

let recieveMovieID: String = "DidRecieveMovies"
let DidRecievedMoviesNotification: Notification.Name = Notification.Name(recieveMovieID)

func requestMoovies() {
//    let testURL: String = "https://connect-boxoffice.run.goorm.io/"
    let testURL: String = "https://connect-boxoffice.run.goorm.io/movies"
    guard let url: URL = URL(string: testURL) else { return }
    
    let session: URLSession = URLSession(configuration: .default)
    let dataTask: URLSessionDataTask = session.dataTask(with: url) { (data: Data?, urlResponse: URLResponse?, error: Error?) in
        guard let data = data else { return }
        do {
            let apiResponse: MovieList =  try JSONDecoder().decode(MovieList.self, from: data)
            NotificationCenter.default.post(name: DidRecievedMoviesNotification, object: nil, userInfo: ["movies":apiResponse.movies])
        } catch let err {
            print("\n\n---> 🤮🤮 err.localizedDescription : \(err.localizedDescription)")
        }
    }
    dataTask.resume()
}
