//
//  ViewController.swift
//  Networking
//
//  Created by inooph on 2021/09/07.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier: String = "friendCell"
    var friends: [Friend] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        let friend: Friend = self.friends[indexPath.row]
        cell.textLabel?.text = friend.name.full
        cell.detailTextLabel?.text = friend.email
        
        guard let imageURL: URL = URL(string: friend.picture.thumbnail) else { return cell }
        guard let imageData: Data = try? Data(contentsOf: imageURL) else { return cell }
        cell.imageView?.image = UIImage(data: imageData)
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //let testURL1_x: String = "https://randomuser.me/api/?results=20&inc=name,email,picture"
        let testURL1: String = "https://randomuser.me/api/?results=20&inc=name,email,picture"
        //Your api key is LTJ0-4BY0-UZVQ-E366

        let testURL3: String = " https://randomapi.com/api/1234abcd?key=LTJ0-4BY0-UZVQ-E366"
        guard let url: URL = URL(string: testURL1) else { return }
        
        let session: URLSession = URLSession(configuration: .default)
        let dataTask: URLSessionDataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in // 응답왔을 때 실행되는 코드블록(클로저)
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let data = data else { return }
            
            do {
                let apiResponse: APIResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                DispatchQueue.main.async {
                    self.friends = apiResponse.results
                    self.tableView.reloadData()
                }
                
            } catch(let err) {
                print(err.localizedDescription)
            }
        }
        dataTask.resume() // 데이터태스크 실행 및 서버 요청
    }
    

}

