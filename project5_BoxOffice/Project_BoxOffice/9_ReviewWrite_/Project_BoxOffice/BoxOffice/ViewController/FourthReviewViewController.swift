//
//  FourthReviewViewController.swift
//  BoxOffice
//
//  Created by inooph on 2021/09/12.
//

import UIKit

class FourthReviewViewController: UIViewController {
    /*
     [화면 3 - 한줄평 작성]
     
     [화면구성]
     - [] 별점을 남길 수 있는 별점선택 영역이 있습니다.
     - [] 닉네임을 작성할 수 있는 텍스트필드가 있습니다.
     - [] 한줄평을 작성할 수 있는 텍스트뷰가 있습니다.
     - [] 내비게이션 아이템으로 '완료'와 '취소'버튼이 있습니다.
     
     [기능]
     - [] 영화에 대한 한줄평을 남길 수 있습니다.
         - [] 5개의 별을 터치 또는 드래그해서 별점을 선택할 수 있습니다.
         - [] 선택된 별이 숫자로 환산돼 별 이미지 아래쪽에 보입니다.
         - [] 별점은 0~10점 사이의 정수단위입니다.
     - [] 작성자의 닉네임과 한줄평을 작성하고 '완료' 버튼을 누르면 새로운 한줄평을 등록하고 등록에 성공하면 이전화면으로 되돌아오고, 새로운 한줄평이 업데이트됩니다.
     - [] 닉네임 또는 한줄평이 모두 작성되지 않은 상태에서 '완료' 버튼을 누르면 경고 알림창이 뜹니다.
     - [] '취소'버튼을 누르면 이전 화면으로 되돌아갑니다.
     - [] 기존에 작성했던 닉네임이 있다면 화면3으로 새로 진입할 때 기존의 닉네임이 입력되어 있습니다.
     */
    
    
    let fourthViewFirstCellIdentifire: String = "fourthViewFirstCell"
    let fourthViewSecondCellIdentifire: String = "fourthViewSecondCell"

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

extension FourthReviewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell: FourthViewFirstTableViewCell = tableView.dequeueReusableCell(withIdentifier: fourthViewSecondCellIdentifire) as? FourthViewFirstTableViewCell else { return UITableViewCell() }
            
            cell.backgroundColor = .red
            return cell
        default:
            let cell = UITableViewCell()
            cell.backgroundColor = .blue
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}
