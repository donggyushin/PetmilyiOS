//
//  NewAccountStep3Controller.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/25.
//

import UIKit

class NewAccountStep3Controller:UIViewController {
    
    // MARK: - Properties
    let userId:String
    let phoneNumber:String
    
    private lazy var passwordTextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "비밀번호를 입력해주세요"
        tf.textAlignment = .center
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.delegate = self
        tf.isSecureTextEntry = true 
        return tf
    }()
    
    private lazy var passwordTextContainer:TextContainer = {
        let tc = TextContainer(textField: passwordTextField)
        return tc
    }()
    
    private lazy var useButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("사용하기", for: UIControl.State.normal)
        bt.widthAnchor.constraint(equalToConstant: view.frame.width * 0.7).isActive = true
        bt.heightAnchor.constraint(equalToConstant: 45).isActive = true
        bt.layer.borderWidth = 1
        bt.layer.borderColor = UIColor.systemBlue.cgColor
        bt.layer.cornerRadius = 9
        bt.addTarget(self, action: #selector(selectPassword), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    private lazy var verticalStack1:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [passwordTextContainer, useButton])
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    // MARK: - Lifecycles
    
    init(userId:String, phoneNumber:String) {
        self.userId = userId
        self.phoneNumber = phoneNumber
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNavigation()
        configureKeyboard()
    }
    
    // MARK: - Configures
    func configureUI() {
        view.backgroundColor = .systemBackground
        clearNavigationBar()
        
        view.addSubview(verticalStack1)
        verticalStack1.translatesAutoresizingMaskIntoConstraints = false
        verticalStack1.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        verticalStack1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        verticalStack1.widthAnchor.constraint(equalToConstant: view.frame.width * 0.7).isActive = true
    }
    func configureKeyboard(){
        moveViewWhenKeyboardIsShown()
        dismissKeyboardWhenTappingAround()
    }
    
    func configureNavigation() {
        navigationItem.title = userId
        navigationItem.backButtonTitle = "이전"
    }
    
    // MARK: - Selectors
    @objc func selectPassword() {
        guard let password = passwordTextField.text else { return }
        
        let result = Utilities.shared.regularExpressionCheckFunction(text: password, regularExpress: Properties.passwordRegex)
        
        if result {
            // 다음으로 넘어가도 됌
            let vc = NewAccountStep4Controller(userId: self.userId, phoneNumber: self.phoneNumber, password: password)
            navigationController?.pushViewController(vc, animated: true)
        }else {
            // 다음으로 넘어가면 안됌
            // Minimum 8 characters at least 1 Alphabet, 1 Number and 1 Special Character
            // 최소 1개의 알파벳, 1개의 숫자 그리고 1개의 특수 문자가 들어간 8자 이상의 비밀번호를 입력해주세요.
            renderPopupWithOkayButtonNoImage(title: "주의", message: "최소 1개의 알파벳, 1개의 숫자 그리고 1개의 특수 문자가 들어간 8자 이상의 비밀번호를 입력해주세요.")
        }
        
    }
}


extension NewAccountStep3Controller:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.passwordTextField {
            guard let textFieldText = textField.text,
                    let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                        return false
                }
                let substringToReplace = textFieldText[rangeOfTextToReplace]
                let count = textFieldText.count - substringToReplace.count + string.count
            
                return count <= 16
        }
        
        return true
    }
}
