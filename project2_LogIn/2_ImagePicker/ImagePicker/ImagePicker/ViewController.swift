//
//  ViewController.swift
//  ImagePicker
//
//  Created by inooph on 2021/08/16.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // 이미지피커 인스턴스 생성
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        return picker
    }()
    
    // 이미지뷰
    @IBOutlet weak var imageView: UIImageView!
    
    // 버튼클릭 시 수행할 메소드
    @IBAction func touchUpSelectImageButton(_ sendeer: UIButton) {
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // delegate 함수 프로토타입(프로토콜 상에서 정의되어 있는 요소들)을 가지고 원하는 기능을 구현
    // 이미지 선택이 취소됐을 때
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("\nfunc -> imagePickerControllerDidCancel")
        self.dismiss(animated: true, completion: nil)
    }
    
    // 이미지가 선택됐을 때
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage: UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imageView.image = originalImage
        }
        print("\nfunc -> imagePickerController didFinishPickingMediaWithInfo")
        self.dismiss(animated: true, completion: nil)
    }
}

