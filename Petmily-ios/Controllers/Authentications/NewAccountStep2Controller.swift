//
//  NewAccountStep2Controller.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/25.
//

import UIKit

class NewAccountStep2Controller: UIViewController {
    
    // MARK: - Properties
    let phoneNumber:String
    var userId:String?
    
    private lazy var idTextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "아이디를 입력해주세요"
        tf.textAlignment = .center
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.delegate = self
        return tf
    }()
    
    private lazy var idTextContainer:TextContainer = {
        let tc = TextContainer(textField: idTextField)
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
        bt.addTarget(self, action: #selector(checkThisIdAvailable), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    private lazy var verticalStack1:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [idTextContainer, useButton])
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    // MARK: - Lifecycles
    init(phoneNumber:String) {
        self.phoneNumber = phoneNumber
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        configureUI()
        configureNavigation()
    }
    
    // MARK: - Configures
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(verticalStack1)
        verticalStack1.translatesAutoresizingMaskIntoConstraints = false
        verticalStack1.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        verticalStack1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        verticalStack1.widthAnchor.constraint(equalToConstant: view.frame.width * 0.7).isActive = true
    }
    
    func configureNavigation() {
        navigationItem.hidesBackButton = true
        clearNavigationBar()
        navigationItem.backButtonTitle = "이전"
    }
    
    func configure(){
        moveViewWhenKeyboardIsShown()
        dismissKeyboardWhenTappingAround()
    }
    
    // MARK: - Helpers
    func goToNextPage(){
        guard let userId = self.userId else { return }
        let vc = NewAccountStep3Controller(userId: userId, phoneNumber: self.phoneNumber)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Selectors
    @objc func checkThisIdAvailable() {
        
        
        useButton.tintColor = .systemGray2
        useButton.layer.borderColor = UIColor.systemGray2.cgColor
        useButton.isEnabled = false
        
        
        
        guard let userId = self.idTextField.text else { return }
        
        self.userId = userId
        
        
        AuthService.shared.checkThisIdAvailable(id: userId) { (success, error, errorMessage, user) in
            
            if let errorMessage = errorMessage {
                self.renderPopupWithOkayButtonNoImage(title: "에러", message: errorMessage)
                self.useButton.tintColor = .systemBlue
                self.useButton.layer.borderColor = UIColor.systemBlue.cgColor
                self.useButton.isEnabled = true
                return
            }
            
            if let error = error {
                self.renderPopupWithOkayButtonNoImage(title: "에러", message: error.localizedDescription)
                
                self.useButton.tintColor = .systemBlue
                self.useButton.layer.borderColor = UIColor.systemBlue.cgColor
                self.useButton.isEnabled = true
                return
            }
            
            
            
            if success == false { return }
            
            if user != nil {
                self.renderPopupWithOkayButtonNoImage(title: "에러", message: "이미 사용중인 아이디입니다. 다른 아이디를 선택해주세요")
                
                self.useButton.tintColor = .systemBlue
                self.useButton.layer.borderColor = UIColor.systemBlue.cgColor
                self.useButton.isEnabled = true
                return
            }
            
            // 아이디 사용가능, 팝업으로 더 진행할 것인지 물어보기
            
            self.useButton.tintColor = .systemBlue
            self.useButton.layer.borderColor = UIColor.systemBlue.cgColor
            self.useButton.isEnabled = true
            self.bottomAlertWithCancelButtonAndOkayButton(title: "성공", message: "사용 가능한 아이디입니다. 계속 진행하시겠습니가?", cancleText: "아니요", okayText: "네", okayFunction: self.goToNextPage)
            
            
        }
    }
    
    
}

extension NewAccountStep2Controller:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.idTextField {
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
