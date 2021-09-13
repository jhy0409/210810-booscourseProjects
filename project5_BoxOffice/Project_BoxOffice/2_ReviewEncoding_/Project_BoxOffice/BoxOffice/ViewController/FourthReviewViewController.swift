//
//  FourthReviewViewController.swift
//  BoxOffice
//
//  Created by inooph on 2021/09/12.
//

import UIKit

class FourthReviewViewController: UIViewController, UITextFieldDelegate {
    /*
     [화면 3 - 한줄평 작성] =============
     
     [화면구성]
     - [ㅇ] 별점을 남길 수 있는 별점선택 영역이 있습니다.
     - [ㅇ] 닉네임을 작성할 수 있는 텍스트필드가 있습니다.
     - [ㅇ] 한줄평을 작성할 수 있는 텍스트뷰가 있습니다.
     - [ㅇ] 내비게이션 아이템으로 '완료'와 '취소'버튼이 있습니다.
     
     [기능]
     - [ㅇ] 영화에 대한 한줄평을 남길 수 있습니다.
         - [ㅇ] 5개의 별을 터치 또는 드래그해서 별점을 선택할 수 있습니다.
         - [ㅇ] 선택된 별이 숫자로 환산돼 별 이미지 아래쪽에 보입니다.
         - [ㅇ] 별점은 0~10점 사이의 정수단위입니다.
     - [ㅇ] 작성자의 닉네임과 한줄평을 작성하고 '완료' 버튼을 누르면 새로운 한줄평을 등록하고 등록에 성공하면 이전화면으로 되돌아오고, 새로운 한줄평이 업데이트됩니다.
     - [ㅇ] 닉네임 또는 한줄평이 모두 작성되지 않은 상태에서 '완료' 버튼을 누르면 경고 알림창이 뜹니다.
     - [ㅇ] '취소'버튼을 누르면 이전 화면으로 되돌아갑니다.
     - [] 기존에 작성했던 닉네임이 있다면 화면3으로 새로 진입할 때 기존의 닉네임이 입력되어 있습니다.
     
     
     [Grand Central Dispatch] =============

     - [ㅇ] 백그라운드 네트워킹
        - [ㅇ] 네트워킹은 백그라운드 스레드에서 진행되어야 합니다.
     - [ㅇ] 이미지 로드
        - [ㅇ] 테이블뷰/컬렉션뷰 셀의 이미지 불러오기는 비동기로 백그라운드 스레드에서 처리해야 합니다.
     - [ㅇ] 메인 스레드
        - [ㅇ] UI 요소 표기는 메인 스레드에서 진행해야 합니다.
      

     [Networking] =============

     - [ㅇ] Indicator
        - [ㅇ] 네트워킹 동작중(로딩/새로고침)에는 상태표시줄(status bar)와 화면에 인디케이터를 사용해 사용자에게 네트워킹 중임을 정확히 표시해야 합니다.
     
     - [ㅇ] Result Handling
        - [ㅇ] 데이터 수신 또는 한줄평 등록에 실패한 경우, 알림창을 통해 사용자에게 결과를 표시해야 합니다.
     
     - [ㅇ] URLSession
        - [ㅇ] 영화정보를 가져오거나 한줄평을 등록하는 과정은 첨부한 API 문서를 참고하여 URLSession을 활용하여 서버와 통신합니다.
     */
    let shared = MovieShared.shared
    var movie: Movie?
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var gradeImageVIew: UIImageView!
    
    @IBOutlet weak var reviewTitleTextField: UITextField!
    @IBOutlet weak var reviewContentsTextField: UITextField!
    @IBOutlet weak var starRatingFloatLabel: UILabel!
    @IBOutlet weak var sliderForRating: UISlider!
    
    var reviewFieldCheck: Bool {
        let checkValue: (Bool?, Bool?) = (reviewTitleTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty, reviewContentsTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty)
        let userRating = userRating == 0 || userRating == nil
        
        guard let check: (Bool, Bool) = checkValue as? (Bool, Bool) else { return false }
        if check.0 == false && check.1 == false && userRating == false {
            return false
        } else { return true }
    }
    
    lazy var urlSession = URLSession.shared
    var userRating: Int?
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        self.starRatingFloatLabel.text = String(Int(sender.value))
    }
    
    @IBAction func draggingSlider(_ sender: UISlider) {
        userRating = Int(calculateScore(sender.value))
    }
    
    func getWriterFromDevice() -> String? {
        guard let writer = UserDefaults.standard.value(forKey: "writer") as? String else { return nil }
        return writer
    }
    
    
    func calculateScore(_ value: Float) -> Int {
        let floatValue = floor(value * 10) / 10
        
        for index in 1...5 {
            if let starImage = view.viewWithTag(index) as? UIImageView {
                if Float(index) <= floatValue  {
                    starImage.image = UIImage(named: "ic_star_large_full")
                } else {
                    if (Float(index) - floatValue) <= 0.5 {
                        starImage.image = UIImage(named: "ic_star_large_half")
                    } else {
                        starImage.image = UIImage(named: "ic_star_large")
                    }
                }
            }
        }
        return Int(floatValue)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTextFields()
        settingNavigationItem()
        guard let movie = self.movie else { return }
        movieTitleLabel.text = movie.title
        gradeImageVIew.image = movie.gradeIcon
        sliderForRating.value = 0
        starRatingFloatLabel.text = "\(sliderForRating.value)"
    }
    
    func settingTextFields() {
        reviewTitleTextField.delegate = self
        reviewContentsTextField.delegate = self
        reviewContentsTextField.layer.borderWidth = 1
        reviewContentsTextField.layer.cornerRadius = 5
        reviewContentsTextField.layer.borderColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
    }
    
    func settingNavigationItem() {
        let leftCancelItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(closeFourthView))
        let rightSubmitItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(submitReview))
        navigationItem.leftBarButtonItem = leftCancelItem
        navigationItem.rightBarButtonItem = rightSubmitItem
    }
    
    @objc func closeFourthView() {
        navigationController?.popViewController(animated: true)
    }
    
    var callbackResult: (() -> ())?
    @objc func submitReview() {
        print("📣 4thView 📣 - fourthView @objc func submitReview()")
        //UserWriteComment
        print("reviewFieldCheck : \(reviewFieldCheck)")
        if reviewFieldCheck == true {
            alert(reviewFieldCheck)
            return
        } else {
            let userRating: Double = Double(userRating! * 2)
            guard let writer = reviewTitleTextField.text, let contents = reviewContentsTextField.text, let movieID = movie?.id else { return }
            
            print(" - userRating: \(userRating)\n - writer: \(writer)\n - contents: \(contents)\n - movieID: \(movieID)")
            
            let writtenDate: Date = Date()
            let timeStamp = writtenDate.timeIntervalSince(writtenDate)
            
            let userReviewData = UserWriteComment(rating: userRating, timestamp: timeStamp, writer: writer, movie_id: movieID, contents: contents)
            
            guard let data = try? JSONEncoder().encode(userReviewData) else { return }
            guard let url = URL(string: "https://connect-boxoffice.run.goorm.io/comment") else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("appllication/json", forHTTPHeaderField: "Content-Type")
            urlSession.uploadTask(with: request, from: data) { data, response, error in
                if let  response = response as? HTTPURLResponse {
                    if (200 ... 299).contains(response.statusCode) && error == nil {
                        print("n\n---> 💖fourthView💖 - submit success 💖💖")
                        DispatchQueue.main.async {
                            print("fourthView - callbackResult: \(self.callbackResult)")
                            self.callbackResult?()
                            self.navigationController?.popViewController(animated: true)
                            
                        }
                    } else {
                        self.alertNetworking(data, response, error)
                    }
                }
            }.resume()
        }
        print("📣📣 2. comments.count : \(shared.movieComments?.comments.count)")
    }
    
    func alert(_ isEmptyTextFields: Bool) {
        if isEmptyTextFields == true {
            let alert = UIAlertController(title: "안내", message: "모든 값을 채워주세요.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        movieTitleLabel.becomeFirstResponder()
        reviewContentsTextField.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        movieTitleLabel.resignFirstResponder()
        reviewContentsTextField.resignFirstResponder()
    }
    
    func setWriter(_ writer: String) {
        // empty -> true(F) / notNil -> false(T)
        if !writer.isEmpty {
            UserDefaults.standard.set(writer, forKey: "writer")
        }
    }
    
    private func alertNetworking(_ data: Data?, _ response: URLResponse? , _ error: Error?) {
        print("🤮 fourthVC - alert1 🤮 func alertNetworking(_ error: Error?)")
        guard let error = error else { return }
        let errorDescription: String = error.localizedDescription
        let alert = UIAlertController(title: "알림", message: errorDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

