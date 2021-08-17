//
//  ViewController.swift
//  MyDatePicker
//
//  Created by inooph on 2021/08/17.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
         // formatter.dateStyle = .medium // 지정스타일
         // formatter.timeStyle = .medium
        
        // formatter.dateFormat = "yyyy.mm.dd hh:mm:ss"
         formatter.dateFormat = "yyyy.m.d h:m:s"
        
        // 현지화된 날짜 형식을 지정
        // formatter.locale = Locale(identifier: "ko_KR")
        // formatter.setLocalizedDateFormatFromTemplate("yyyyMMMd h:m:s")
        return formatter
    }()
    
    @IBAction func didDatePickerValueChanged(_ sender: UIDatePicker) {
        print("value changed")
        
        // let date: Date = sender.date
        let date: Date = self.datePicker.date
        let dateString: String =  self.dateFormatter.string(from: date)
        self.dateLabel.text = dateString
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.datePicker.addTarget(self, action: #selector(self.didDatePickerValueChanged(_:)), for: UIControl.Event.valueChanged)
    }


}

