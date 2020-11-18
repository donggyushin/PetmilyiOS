//
//  NewAccountStep5Controller.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/25.
//

import UIKit

class NewAccountStep5Controller:UIViewController {
    
    // MARK: - Properties
    let userId:String
    let phoneNumber:String
    let password:String
    
    private lazy var nicknameTextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "별명을 입력해주세요"
        tf.textAlignment = .center
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.delegate = self
        return tf
    }()
    
    private lazy var nicknameContainer:TextContainer = {
        let tc = TextContainer(textField: nicknameTextField)
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
        let stack = UIStackView(arrangedSubviews: [nicknameContainer, useButton])
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    
    
    // MARK: - Lifecycles
    init(userId:String, password:String, phoneNumber:String) {
        self.userId = userId
        self.password = password
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
        navigationItem.title = self.userId
        
        view.addSubview(verticalStack1)
        verticalStack1.translatesAutoresizingMaskIntoConstraints = false
        verticalStack1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        verticalStack1.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        
    }
    
    func configureNavigation() {
        navigationItem.title = userId
        navigationItem.backButtonTitle = "이전"
    }
    
    func configureKeyboard() {
        moveViewWhenKeyboardIsShown()
        dismissKeyboardWhenTappingAround()
    }
    
    // MARK: selectors
    @objc func useButtonTapped() {
        guard let nickname = self.nicknameTextField.text else { return }
        
        if nickname.count <= 1 {
            renderPopupWithOkayButtonNoImage(title: "알림", message: "닉네임은 2자 이상 입력해주세요")
            return
        }
        
        if Utilities.shared.nonuseableNicknameCheck(nickname: nickname) == false {
            renderPopupWithOkayButtonNoImage(title: "알림", message: "사용할 수 없는 단어가 포함되어 있습니다")
            return
        }
        
        if Utilities.shared.regularExpressionCheckFunction(text: nickname, regularExpress: Properties.nicknameRegex) == false {
            renderPopupWithOkayButtonNoImage(title: "알림", message: "한글만 입력할 수 있습니다")
            return
        }
        
        
        self.nicknameTextField.endEditing(true)
        
        // TODO: - NewAccountStep6Controller 로 보내주기
        let vc = NewAccountStep6Controller(userId: self.userId, phoneNumber: self.phoneNumber, password: self.password, nickname: nickname)
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
}


extension NewAccountStep5Controller:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.nicknameTextField {
            guard let textFieldText = textField.text,
                    let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                        return false
                }
                let substringToReplace = textFieldText[rangeOfTextToReplace]
                let count = textFieldText.count - substringToReplace.count + string.count
            
                return count <= 5
        }
        
        return true
    }
}
