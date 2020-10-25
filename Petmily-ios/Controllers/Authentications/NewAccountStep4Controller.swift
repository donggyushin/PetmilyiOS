//
//  NewAccountStep4Controller.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/25.
//

import UIKit

class NewAccountStep4Controller:UIViewController {
    
    // MARK: - Properties
    let userId:String
    let phoneNumber:String
    let password:String
    
    private lazy var passwordTextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "비밀번호를 다시 한 번 입력해주세요"
        tf.textAlignment = .center
        tf.font = UIFont.systemFont(ofSize: 18)
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
        bt.addTarget(self, action: #selector(useButtonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    private lazy var verticalStack1:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [passwordTextContainer, useButton])
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    // MARK: - Lifecycles
    
    init(userId:String, phoneNumber:String, password:String) {
        self.userId = userId
        self.phoneNumber = phoneNumber
        self.password = password
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
    @objc func useButtonTapped(){
        
        guard let password = self.passwordTextField.text else { return }
        if self.password != password {
            renderPopupWithOkayButtonNoImage(title: "주의", message: "이전에 입력한 비밀번호와 일치하지 않습니다")
        }else {
            // 다음 페이지로 넘겨주기
            let vc = NewAccountStep5Controller(userId: userId, password: password, phoneNumber: phoneNumber)
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
}



extension NewAccountStep4Controller:UITextFieldDelegate {
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
