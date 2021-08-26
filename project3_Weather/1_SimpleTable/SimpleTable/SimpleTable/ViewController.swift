//
//  ViewController.swift
//  SimpleTable
//
//  Created by inooph on 2021/08/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier: String = "cell"
    let customCellIdentifier: String = "customCell"
    
    let korean: [String] = ["가", "나", "다", "라", "마",  "바", "사", "아", "자", "차", "카", "타", "파", "하"]
    let english: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    // let korean: [String] = ["가", "나", "다"]
    // let english: [String] = ["A", "B"]
    
    var dates: [Date] = []
    // var dates: [String] = []
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        let today = Date()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
    
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        let today = Date()
        formatter.timeStyle = .medium
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
    
    @IBAction func touchUpAddButton(_ sender: UIButton) {
        // let dateStr = dateFormatter.string(from: Date())
        dates.append(Date())
        // self.tableView.reloadData() // 전체 다시 불러오기 때문에 비효율적
        self.tableView.reloadSections(IndexSet(2...2), with: UITableView.RowAnimation.automatic)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 코드로 하기
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
}

extension ViewController: UITableViewDataSource {
    // 섹션 몇개
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return korean.count
        case 1:
            return english.count
        case 2:
            return dates.count
        default:
            return 0
        }
    }
    
    // 셀 그리는 것
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // dequeueReusableCell : 큐에 쌓여있던 재사용 가능한 셀 꺼내와서 쓴다는 뜻
        // 화면 벗어난 셀을 다른 큐에 담아놓고 다시 사용
        if indexPath.section < 2 {
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
            let text: String = indexPath.section == 0 ? korean[indexPath.row] : english[indexPath.row]
            cell.textLabel?.text = text
            
            // 재사용 여부 확인
            // let cell: UITableViewCell = UITableViewCell()
            if indexPath.row == 1 {
                cell.backgroundColor = .red
            } else {
                cell.backgroundColor = .systemBackground
            }
            
            return cell
        } else {
            let cell: CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.customCellIdentifier, for: indexPath) as! CustomTableViewCell
            cell.leftLabel.text = self.dateFormatter.string(from: self.dates[indexPath.row])
            cell.rightLabel.text = self.timeFormatter.string(from: self.dates[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < 2 {
            return section == 0 ? "한글" : "영어"
        } else {
            return "날짜"
        }
    }
    
    // 색변경 - 섹션 배경, 글자
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let hdView = view as? UITableViewHeaderFooterView {
            hdView.contentView.backgroundColor = .systemBlue
            hdView.textLabel?.textColor = .white
        }
    }
    
    /*
     In a storyboard-based application, you will often want to do a little preparation before navigation
     스토리보드 기반 애플리케이션에서 탐색 전에 약간의 준비를 하고 싶을 때가 많습니다.
     
     Get the new view controller using segue.destination.
     segue.destination을 사용하여 새 뷰 컨트롤러를 가져옵니다.
     
     Pass the selected object to the new view controller.
     선택한 객체를 새 뷰 컨트롤러에 전달합니다.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController: SecondViewController = segue.destination as? SecondViewController else { return }
        
        // sender : navigation 흐름을 만드는 테이블뷰 셀
        guard let cell: UITableViewCell = sender as? UITableViewCell else { return }
        
        nextViewController.textToSet = cell.textLabel?.text
        // 런타임에러 : 메모리에 올라와 있지 않으므로 Exception 발생
        // 명령어 : 메모리 올라왔는지 확인 -> 커맨드 창에서 po nextViewController, po nextViewController.textLabel = nil
        // nextViewController.textLabel.text = cell.textLabel?.text
        
        // 세그가 여러개일 때 : segue.identifier
    }
}

extension ViewController: UITableViewDelegate {
    
}
