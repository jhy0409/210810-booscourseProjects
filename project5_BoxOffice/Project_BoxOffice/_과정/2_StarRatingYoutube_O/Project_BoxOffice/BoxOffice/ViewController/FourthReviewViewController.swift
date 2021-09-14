//
//  FourthReviewViewController.swift
//  BoxOffice
//
//  Created by inooph on 2021/09/12.
//

import UIKit

class FourthReviewViewController: UIViewController, UITextFieldDelegate {
    /*
     [화면 3 - 한줄평 작성]
     
     [화면구성]
     - [] 별점을 남길 수 있는 별점선택 영역이 있습니다.
     - [ㅇ] 닉네임을 작성할 수 있는 텍스트필드가 있습니다.
     - [ㅇ] 한줄평을 작성할 수 있는 텍스트뷰가 있습니다.
     - [ㅇ] 내비게이션 아이템으로 '완료'와 '취소'버튼이 있습니다.
     
     [기능]
     - [] 영화에 대한 한줄평을 남길 수 있습니다.
         - [] 5개의 별을 터치 또는 드래그해서 별점을 선택할 수 있습니다.
         - [] 선택된 별이 숫자로 환산돼 별 이미지 아래쪽에 보입니다.
         - [] 별점은 0~10점 사이의 정수단위입니다.
     - [] 작성자의 닉네임과 한줄평을 작성하고 '완료' 버튼을 누르면 새로운 한줄평을 등록하고 등록에 성공하면 이전화면으로 되돌아오고, 새로운 한줄평이 업데이트됩니다.
     - [] 닉네임 또는 한줄평이 모두 작성되지 않은 상태에서 '완료' 버튼을 누르면 경고 알림창이 뜹니다.
     - [ㅇ] '취소'버튼을 누르면 이전 화면으로 되돌아갑니다.
     - [] 기존에 작성했던 닉네임이 있다면 화면3으로 새로 진입할 때 기존의 닉네임이 입력되어 있습니다.
     */
    var movie: Movie?
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var gradeImageVIew: UIImageView!
    
    @IBOutlet weak var reviewTitleTextField: UITextField!
    @IBOutlet weak var reviewContentsTextField: UITextField!
    @IBOutlet weak var starRatingFloatLabel: UILabel!
    
    @IBOutlet var starButtons: [UIButton]!
    
    
    let shared = MovieShared.shared
    
    @IBAction func starButtonTapped(_ sender: UIButton) {
        print("\n💖---> Rated \(sender.tag) star")
        
        for button in starButtons {
            if button.tag <= sender.tag {
                button.setBackgroundImage(UIImage.init(named: "ic_star_large_full"), for: .normal)
            } else {
                button.setBackgroundImage(UIImage.init(named: "ic_star_large"), for: .normal)
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let movie = self.movie else { return }
        movieTitleLabel.text = movie.title
        gradeImageVIew.image = movie.gradeIcon
        
        
        
        reviewTitleTextField.delegate = self
        reviewContentsTextField.delegate = self
        reviewContentsTextField.layer.borderWidth = 1
        reviewContentsTextField.layer.cornerRadius = 5
        
//        starRatingFloatLabel.text = "\(StarRatingView.resultSum)"
        
        
        reviewContentsTextField.layer.borderColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
        let leftCancelItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(closeFourthView))
        let rightSubmitItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(submitReview))
        navigationItem.leftBarButtonItem = leftCancelItem
        navigationItem.rightBarButtonItem = rightSubmitItem
        print("💋1. comments.count : \( shared.movieComments?.comments.count)")
    }
    
    @objc func closeFourthView() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func submitReview() {
        print("💋💋💋💋💋💋💋💋💋💋💋💋")
        let writtenDate: Date = Date()
        let timeStamp = writtenDate.timeIntervalSince1970
        shared.movieComments?.comments.append(Comment(rating: 4.0, timestamp: timeStamp, writer: "💋💋210912💋", movie_id: "\(String(describing: movie?.id))", contents: "💋💋💋💋💋💋"))
        print("💋💋2. comments.count : \( shared.movieComments?.comments.count)")
        navigationController?.popViewController(animated: true)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

