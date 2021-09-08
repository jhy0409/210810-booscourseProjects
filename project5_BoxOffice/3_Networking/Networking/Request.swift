//
//  Request.swift
//  Networking
//
//  Created by inooph on 2021/09/08.
//

import Foundation

let DidRecieveFriendsNotification: Notification.Name = Notification.Name("DidRecieveFriends")

func requestFriend() {
    let testURL1: String = "https://randomuser.me/api/?results=20&inc=name,email,picture"
    guard let url: URL = URL(string: testURL1) else { return }
    
    let session: URLSession = URLSession(configuration: .default)
    let dataTask: URLSessionDataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in // 응답왔을 때 실행되는 코드블록(클로저)
        if let error = error {
            print(error.localizedDescription)
        }
        
        guard let data = data else { return }
        
        do {
            let apiResponse: APIResponse = try JSONDecoder().decode(APIResponse.self, from: data)
            NotificationCenter.default.post(name: DidRecieveFriendsNotification, object: nil, userInfo: ["friends":apiResponse.results])
            DispatchQueue.main.async {
                //    self.tableView.reloadData()
            }
            
        } catch(let err) {
            print(err.localizedDescription)
        }
    }
    dataTask.resume() // 데이터태스크 실행 및 서버 요청
}
