//
//  ViewController.swift
//  Alert
//
//  Created by inooph on 2021/09/06.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func touchUpShowAlertButton(_ sender: UIButton) {
        self.showAlertController(style: UIAlertController.Style.alert)
    }
    
    @IBAction func touchUpShowActionSheetButton(_ sender: UIButton) {
        self.showAlertController(style: UIAlertController.Style.actionSheet)
    }
    
    func showAlertController(style: UIAlertController.Style) {
        let alertController: UIAlertController
        alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: style)
        
        let okAction: UIAlertAction
        okAction = UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction) in
            print("OK pressed")
        })
        
        let cancelAction: UIAlertAction
        cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        let handler: (UIAlertAction) -> Void
        handler = { (action: UIAlertAction) in
            print("action pressed \(action.title ?? "")")
        }
        
        let someAction: UIAlertAction
        someAction = UIAlertAction(title: "Some", style: .destructive, handler: handler)
        
        let anotherAction: UIAlertAction
        //anotherAction = UIAlertAction(title: "Another", style: .cancel, handler: handler)
        anotherAction = UIAlertAction(title: "Another", style: .default, handler: handler)
        
        alertController.addAction(someAction)
        alertController.addAction(anotherAction)
        
        if style == .alert {
            alertController.addTextField(configurationHandler: {(field: UITextField) in
                field.placeholder = "플레이스 홀더"
                field.textColor = UIColor.red
            })
        }
        
        self.present(alertController, animated: true, completion: {
            print("Alert controller shown")
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

