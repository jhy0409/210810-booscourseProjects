//
//  ViewController.swift
//  PJT2-SignUp
//
//  Created by 김광준 on 2019/10/22.
//  Copyright © 2019 VincentGeranium. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    static let naviVC = UINavigationController(rootViewController: SecondViewController())
    static let idTextField = UITextField()
    let pwTextField = UITextField()
    let signInBtn = UIButton(type: .custom)
    let signUpBtn = UIButton(type: .custom)
    let titleImgView = UIImageView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        addViewsWithCode()
        
    }
    
    private func addViewsWithCode() {
        addTitleImgView()
        addIdTextField()
        addPwTextField()
        addSignInBtn()
        addSignUpBtn()
        
    }
    
    // MARK: - addTitleImgView
    /// 메인 이미지 뷰에 이미지 넣기와 오토레이아웃
    private func addTitleImgView() {
        
        guard let titleImg: UIImage = UIImage.init(named: "boostcourseImg") else {
            print("Error : titleImg의 이미지를 가져올 수 없습니다")
            return
        }
        
        titleImgView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(titleImgView)
        
        let guide = view.safeAreaLayoutGuide
        
        let imgViewWidthValue = (view.bounds.size.width - (view.bounds.size.width - 180))
        let imgViewHeightValue = (view.bounds.size.height - (view.bounds.size.height - 180))
        
        let titleImgTopAnchor: NSLayoutConstraint
        titleImgTopAnchor = titleImgView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 20)
        
        let titleImgCenterX: NSLayoutConstraint
        titleImgCenterX = titleImgView.centerXAnchor.constraint(equalTo: guide.centerXAnchor)
        
        let titleImgWidth: NSLayoutConstraint
        titleImgWidth = titleImgView.widthAnchor.constraint(equalToConstant: imgViewWidthValue)
        
        let titleImgHeight: NSLayoutConstraint
        titleImgHeight = titleImgView.heightAnchor.constraint(equalToConstant: imgViewHeightValue)
       
        titleImgTopAnchor.isActive = true
        titleImgCenterX.isActive = true
        titleImgWidth.isActive = true
        titleImgHeight.isActive = true
        
        titleImgView.image = titleImg
    }
    
    // MARK: - addIdTextField
    /// id를 넣는 텍스트 필드의 오토레이아웃
    private func addIdTextField() {
        
        FirstViewController.idTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(FirstViewController.idTextField)
        
        let guide = view.safeAreaLayoutGuide
        
        let idTextFieldHeightValue = (view.bounds.size.height - (view.bounds.size.height - 34))
        
        let idTop: NSLayoutConstraint
        idTop = FirstViewController.idTextField.topAnchor.constraint(equalTo: titleImgView.bottomAnchor, constant: 20)
        
        let idLeading: NSLayoutConstraint
        idLeading = FirstViewController.idTextField.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 40)
        
        let idTrailing: NSLayoutConstraint
        idTrailing = FirstViewController.idTextField.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -40)
        
        let idHeight: NSLayoutConstraint
        idHeight = FirstViewController.idTextField.heightAnchor.constraint(equalToConstant: idTextFieldHeightValue)
        
        idTop.isActive = true
        idLeading.isActive = true
        idTrailing.isActive = true
        idHeight.isActive = true

        FirstViewController.idTextField.placeholder = "ID"
        FirstViewController.idTextField.borderStyle = .roundedRect
    }
    
    // MARK: - addPwTextField
    /// Password 텍스트 필드 오토레이아웃
    private func addPwTextField() {
        
        pwTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(pwTextField)
        
        let guide = view.safeAreaLayoutGuide
        
        let pwTextFieldHeightValue = (view.bounds.size.height - (view.bounds.size.height - 34))
        
        let pwTop: NSLayoutConstraint
        pwTop = pwTextField.topAnchor.constraint(equalTo: FirstViewController.idTextField.bottomAnchor, constant: 20)
        
        let pwLeading: NSLayoutConstraint
        pwLeading = pwTextField.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 40)
        
        let pwTrailing: NSLayoutConstraint
        pwTrailing = pwTextField.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -40)
        
        let pwHeight: NSLayoutConstraint
        pwHeight = pwTextField.heightAnchor.constraint(equalToConstant: pwTextFieldHeightValue)
        
        pwTop.isActive = true
        pwLeading.isActive = true
        pwTrailing.isActive = true
        pwHeight.isActive = true
        
        
        pwTextField.placeholder = "Password"
        pwTextField.borderStyle = .roundedRect
    }
    
    // MARK: - addSignInBtn
    /// Sign In Button 오토레이아웃과 Target-Action
    private func addSignInBtn() {
        
        signInBtn.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(signInBtn)
        
        signInBtn.setTitle("Sign In", for: .normal)
        signInBtn.setTitleColor(.blue, for: .normal)
        
        let guide = view.safeAreaLayoutGuide
        
        let signInBtnWidthValue = (view.bounds.size.width - (view.bounds.size.width - 100))
        
        let signInBtnHeightValue = (view.bounds.size.height - (view.bounds.size.height - 34))
        
        let signInBtnTop: NSLayoutConstraint
        signInBtnTop = signInBtn.topAnchor.constraint(equalTo: pwTextField.bottomAnchor, constant: 20)
        
        let signInBtnLeading: NSLayoutConstraint
        signInBtnLeading = signInBtn.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 80)
        
        let signInBtnWidth: NSLayoutConstraint
        signInBtnWidth = signInBtn.widthAnchor.constraint(equalToConstant: signInBtnWidthValue)
        
        let signInBtnHeight: NSLayoutConstraint
        signInBtnHeight = signInBtn.heightAnchor.constraint(equalToConstant: signInBtnHeightValue)
        
        signInBtnTop.isActive = true
        signInBtnLeading.isActive = true
        signInBtnWidth.isActive = true
        signInBtnHeight.isActive = true
        
        // MARK: - signInBtn Target-Action
        signInBtn.addTarget(self, action: #selector(didTappedSignInBtn(_:)), for: .touchUpInside)
        
    }
    
    // MARK: - didTappedSignInBtn
    /// Sign In Button을 눌렀을때 동작
    @objc  private func didTappedSignInBtn(_ sender: UIButton) {
        print("Sign In 버튼 정상 동작")
    }
    
    // MARK: - addSignUpBtn
    /// Sign Up Button 의 오토레이아웃과 Target-Action
    private func addSignUpBtn() {
        
        signUpBtn.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(signUpBtn)
        
        signUpBtn.setTitle("Sign Up", for: .normal)
        signUpBtn.setTitleColor(.red, for: .normal)
        
        let guide = view.safeAreaLayoutGuide
        
        let signUpBtnTop: NSLayoutConstraint
        signUpBtnTop = signUpBtn.topAnchor.constraint(equalTo: pwTextField.bottomAnchor, constant: 20)
        
        let signUpBtnTrailing: NSLayoutConstraint
        signUpBtnTrailing = signUpBtn.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -80)
        
        let signUpBtnWidth: NSLayoutConstraint
        signUpBtnWidth = signUpBtn.widthAnchor.constraint(equalTo: signInBtn.widthAnchor, multiplier: 1.0)
        
        let signUpBtnHeight: NSLayoutConstraint
        signUpBtnHeight = signUpBtn.heightAnchor.constraint(equalTo: signInBtn.heightAnchor, multiplier: 1.0)
        
        signUpBtnTop.isActive = true
        signUpBtnTrailing.isActive = true
        signUpBtnWidth.isActive = true
        signUpBtnHeight.isActive = true
        
        // MARK: - signUpBtn Target-Action
        signUpBtn.addTarget(self, action: #selector(didTappedSignUpBtn(_:)), for: .touchUpInside)
        
    }
    
    // MARK: - didTappedSignUpBtn
    /// Sign Up Button을 눌럿을때 동작
    @objc private func didTappedSignUpBtn(_ sender: UIButton) {
        
        let secondVC = FirstViewController.naviVC
        
        self.present(secondVC, animated: true, completion: nil)
        
    }
}

