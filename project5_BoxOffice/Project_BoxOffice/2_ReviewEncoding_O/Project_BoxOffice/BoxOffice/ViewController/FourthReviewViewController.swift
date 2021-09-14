//
//  FourthReviewViewController.swift
//  BoxOffice
//
//  Created by inooph on 2021/09/12.
//

import UIKit

class FourthReviewViewController: UIViewController, UITextFieldDelegate {
    let shared = MovieShared.shared
    var movie: Movie?
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var gradeImageVIew: UIImageView!
    @IBOutlet weak var thirdImageViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var thirdImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var ratingValueConstraintFromStars: NSLayoutConstraint!
    @IBOutlet weak var reviewTitleFromRatingContraint: NSLayoutConstraint!
    @IBOutlet weak var reviewTitleTextField: UITextField!
    @IBOutlet weak var reviewContentsTextField: UITextField!
    
    @IBOutlet weak var starRatingFloatLabel: UILabel!
    @IBOutlet weak var sliderForRating: UISlider!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
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
    var callbackResult: (() -> ())?
    
    // MARK: - [ㅇ] 드래그해서 별점 주기
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        self.starRatingFloatLabel.text = String(Int(sender.value))
    }
    
    @IBAction func draggingSlider(_ sender: UISlider) {
        userRating = Int(calculateScore(sender.value))
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
    
    // MARK: - [ㅇ] view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicator.isHidden = true
        settingTextFields() // 초기세팅
        settingNavigationItem()
        
        guard let movie = self.movie else { return } // 받아온 영화정보로 세팅
        reviewTitleTextField.text = getWriterFromDevice()
        
        movieTitleLabel.text = movie.title
        gradeImageVIew.image = movie.gradeIcon
        sliderForRating.value = 0
        starRatingFloatLabel.text = "\(sliderForRating.value)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        movieTitleLabel.becomeFirstResponder() // 텍스트 필드 클릭 시 키보드 띄우기
        reviewContentsTextField.becomeFirstResponder()
        
        if UIDevice.current.orientation.isLandscape == true { // 뷰가 가로일 때
            thirdImageViewConstraint.constant = 20
            thirdImageViewHeightConstraint.constant = 20
            reviewTitleFromRatingContraint.constant = 20
            ratingValueConstraintFromStars.constant = 10
        } else {
            thirdImageViewConstraint.constant = 48
            thirdImageViewHeightConstraint.constant = 48
            reviewTitleFromRatingContraint.constant = 50
            ratingValueConstraintFromStars.constant = 30.5
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if UIDevice.current.orientation.isLandscape == true { // 뷰가 가로일 때
            thirdImageViewConstraint.constant = 20
            thirdImageViewHeightConstraint.constant = 20
            reviewTitleFromRatingContraint.constant = 20
            ratingValueConstraintFromStars.constant = 10
        } else {
            thirdImageViewConstraint.constant = 48
            thirdImageViewHeightConstraint.constant = 48
            reviewTitleFromRatingContraint.constant = 50
            ratingValueConstraintFromStars.constant = 30.5
        }
    }
    
    // MARK: - [ㅇ] 뷰 초기화
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
    
    // MARK: - [ㅇ] 리뷰내용 작성 관련
    @objc func closeFourthView() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func submitReview() {
        indicatorShow(false, self.indicator)
        print("📣 4thView 📣 - fourthView @objc func submitReview()")
        print("reviewFieldCheck : \(reviewFieldCheck)")
        if reviewFieldCheck == true {
            alert(reviewFieldCheck)
            return
        } else {
            let userRating: Double = Double(userRating! * 2)
            guard let writer = reviewTitleTextField.text, let contents = reviewContentsTextField.text, let movieID = movie?.id else { return }
            
            let timeStamp = Date().timeIntervalSince1970
            print(" - timeStamp: \(timeStamp)\n - userRating: \(userRating)\n - writer: \(writer)\n - contents: \(contents)\n - movieID: \(movieID)")
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
                            print("fourthView - callbackResult: \(String(describing: self.callbackResult))")
                            self.callbackResult?()
                            self.setWriter(writer)
                            indicatorShow(true, self.indicator)
                            self.navigationController?.popViewController(animated: true)
                        }
                    } else {
                        indicatorShow(true, self.indicator)
                        self.alertNetworking(data, response, error)
                    }
                }
            }.resume()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        reviewTitleTextField.resignFirstResponder()
        reviewContentsTextField.resignFirstResponder()
    }
    
    // MARK: - [ㅇ] 기기 닉네임 저장
    func getWriterFromDevice() -> String? {
        if let writer = UserDefaults.standard.value(forKey: "writer") as? String {
            return writer
        }
        return nil
    }
    
    func setWriter(_ writer: String) {
        // empty -> true(F) / notNil -> false(T)
        if !writer.isEmpty {
            UserDefaults.standard.set(writer, forKey: "writer")
        }
    }
    
    // MARK: - [ㅇ] 경고창
    func alert(_ isEmptyTextFields: Bool) {
        if isEmptyTextFields == true {
            let alert = UIAlertController(title: "안내", message: "모든 값을 채워주세요.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    private func alertNetworking(_ data: Data?, _ response: URLResponse? , _ error: Error?) {
        print("🔵 fourthVC - alert1 🔵 func alertNetworking(_ error: Error?)")
        guard let error = error else { return }
        let errorDescription: String = error.localizedDescription
        let alert = UIAlertController(title: "알림", message: errorDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

