//
//  ViewController.swift
//  ViewTransition
//
//  Created by inooph on 2021/08/16.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("\n1. ViewController의 view가 메모리에 로드됨\t-viewDidLoad")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("2. ViewController의 view가 화면에 보여질 예정\t-viewWillAppear")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("3. ViewController의 view가 화면에 보여짐\t\t-viewDidAppear")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("4. ViewController의 view가 화면에서 사라질 예정\t-viewWillDisappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("5. ViewController의 view가 화면에서 사라짐\t-viewDidDisappear")
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("6. ViewController의 view가 레이아웃 하려함\t-viewWillLayoutSubviews")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("7. ViewController의 subview를 레이아웃 함\t-viewDidLayoutSubviews")
    }
}

