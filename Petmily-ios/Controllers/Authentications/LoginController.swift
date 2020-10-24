//
//  LoginController.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/25.
//

import UIKit

class LoginController:UIViewController {
    
    // MARK: - Properties
    private lazy var idTextField:UITextField = {
        let idTextField = UITextField()
        idTextField.placeholder = "아이디"
        return idTextField
    }()
    
    
    private lazy var idTextContainer:UIView = {
        let view = TextContainer(textField: idTextField)
        return view
    }()
    
    private lazy var pwTextField:UITextField = {
        let idTextField = UITextField()
        idTextField.placeholder = "비밀번호"
        idTextField.isSecureTextEntry = true
        return idTextField
    }()
    
    private lazy var pwTextContainer:UIView = {
        let view = TextContainer(textField: pwTextField)
        return view
    }()
    
    private lazy var loginButton:UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("로그인", for: UIControl.State.normal)
        return button
    }()
    
    private lazy var buttonToNavigateToRegisterController:UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        
        

        var firstAttributes: [NSAttributedString.Key: Any] = [.font:UIFont.systemFont(ofSize: 13),
                                                              .foregroundColor: UIColor.white]
        var secondAttributes:[NSAttributedString.Key: Any] = [.font:UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold),
                                                              .foregroundColor: UIColor.white ]
        
        
        if !isDarkMode {
            firstAttributes = [.font:UIFont.systemFont(ofSize: 13),
                               .foregroundColor: UIColor.black]
            secondAttributes = [.font:UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold),
                                                                  .foregroundColor: UIColor.black ]
        }

        let firstString = NSMutableAttributedString(string: "아직 계정이 없으신가요?  ", attributes: firstAttributes)
        let secondString = NSAttributedString(string: "회원가입", attributes: secondAttributes)
        

        firstString.append(secondString)
        
        button.setAttributedTitle(firstString, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(navigateToNewAccountStep1Controller), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureUI()
        configureNavigationBackButton()
    }
    
    
    
    // MARK: - Configures
    func configureUI(){
        view.backgroundColor = .systemBackground
        navigationItem.title = "PetM!ly"
        clearNavigationBar()
        
        let textContainerStack = UIStackView(arrangedSubviews: [idTextContainer, pwTextContainer])
        textContainerStack.axis = .vertical
        textContainerStack.spacing = 12
        
        view.addSubview(textContainerStack)
        textContainerStack.translatesAutoresizingMaskIntoConstraints = false
        textContainerStack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textContainerStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textContainerStack.widthAnchor.constraint(equalToConstant: view.frame.width * 0.9).isActive = true
        
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: textContainerStack.bottomAnchor, constant: 20).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.9).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(buttonToNavigateToRegisterController)
        buttonToNavigateToRegisterController.translatesAutoresizingMaskIntoConstraints = false
        buttonToNavigateToRegisterController.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        buttonToNavigateToRegisterController.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    func configure(){
        dismissKeyboardWhenTappingAround()
        moveViewWhenKeyboardIsShown()
    }
    
    func configureNavigationBackButton() {
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "이전", style: .plain, target: nil, action: nil)
    }
    
    // MARK: Selectors
    @objc func navigateToNewAccountStep1Controller() {
        let vc = NewAccountStep1Controller()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - iOS dark mode change
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        
        
        
        // 아직 계정이 없으신가요? 텍스트 속성 변경
        var firstAttributes: [NSAttributedString.Key: Any] = [.font:UIFont.systemFont(ofSize: 13),
                                                              .foregroundColor: UIColor.white]
        var secondAttributes:[NSAttributedString.Key: Any] = [.font:UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold),
                                                              .foregroundColor: UIColor.white ]
        
        
        
        if !isDarkMode {
            
            firstAttributes = [.font:UIFont.systemFont(ofSize: 13),
                               .foregroundColor: UIColor.black]
            secondAttributes = [.font:UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold),
                                                                  .foregroundColor: UIColor.black ]
        }

        let firstString = NSMutableAttributedString(string: "아직 계정이 없으신가요?  ", attributes: firstAttributes)
        let secondString = NSAttributedString(string: "회원가입", attributes: secondAttributes)
        

        firstString.append(secondString)
        
        buttonToNavigateToRegisterController.setAttributedTitle(firstString, for: UIControl.State.normal)
        // 아직 계정이 없으신가요? 텍스트 속성 변경
    }
}
