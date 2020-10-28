//
//  NewAccountStep1Controller.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/25.
//

import UIKit

class NewAccountStep1Controller:UIViewController {
    
    // MARK: - Properties
    var phonenumber:String?
    
    
    private lazy var phoneTextField1:UITextField = {
        let tf = UITextField()
        tf.placeholder = "010"
        tf.textAlignment = .center
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.keyboardType = .numberPad
        tf.delegate = self
        tf.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return tf
    }()
    private lazy var phoneTextField2:UITextField = {
        let tf = UITextField()
        tf.textAlignment = .center
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.keyboardType = .numberPad
        tf.delegate = self
        tf.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return tf
    }()
    private lazy var phoneTextField3:UITextField = {
        let tf = UITextField()
        tf.textAlignment = .center
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.keyboardType = .numberPad
        tf.delegate = self
        tf.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return tf
    }()
    
    private lazy var phone1Container:TextContainer = {
        let tc = TextContainer(textField: phoneTextField1)
        return tc
    }()
    
    private lazy var phone2Container:TextContainer = {
        let tc = TextContainer(textField: phoneTextField2)
        return tc
    }()
    
    private lazy var phone3Container:TextContainer = {
        let tc = TextContainer(textField: phoneTextField3)
        return tc
    }()
    
    private lazy var phoneTextFieldStack:UIStackView = {
        let phoneTextFieldStack = UIStackView(arrangedSubviews: [phone1Container, phone2Container, phone3Container])
        phoneTextFieldStack.axis = .horizontal
        phoneTextFieldStack.distribution = .fillEqually
        phoneTextFieldStack.spacing = 20
        return phoneTextFieldStack
    }()
    
    private lazy var verticalStack1:UIStackView = {
        let verticalStack1 = UIStackView(arrangedSubviews: [phoneTextFieldStack, requestVerificationCodeButton])
        verticalStack1.axis = .vertical
        verticalStack1.spacing = 20
        
        return verticalStack1
    }()
    
    private lazy var requestVerificationCodeButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("인증요청", for: UIControl.State.normal)
        bt.widthAnchor.constraint(equalToConstant: view.frame.width * 0.7).isActive = true
        bt.heightAnchor.constraint(equalToConstant: 45).isActive = true
        bt.layer.borderWidth = 1
        bt.layer.borderColor = UIColor.systemBlue.cgColor
        bt.layer.cornerRadius = 9
        bt.addTarget(self, action: #selector(requestVerificationCodeButtonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    private lazy var verificationCodeTextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "597822"
        tf.textAlignment = .center
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        tf.defaultTextAttributes.updateValue(10.0,
             forKey: NSAttributedString.Key.kern)
        return tf
    }()
    
    private lazy var verificationCodeTextFieldContainer:TextContainer = {
       let tc = TextContainer(textField: verificationCodeTextField)
        return tc
    }()
    
    private lazy var verifyButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("인증하기", for: UIControl.State.normal)
        bt.widthAnchor.constraint(equalToConstant: view.frame.width * 0.7).isActive = true
        bt.heightAnchor.constraint(equalToConstant: 45).isActive = true
        bt.layer.borderWidth = 1
        bt.layer.borderColor = UIColor.systemBlue.cgColor
        bt.layer.cornerRadius = 9
        bt.addTarget(self, action: #selector(verify), for: UIControl.Event.touchUpInside)
        
        return bt
    }()
    
    private lazy var verticalStack2:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [verificationCodeTextFieldContainer, verifyButton])
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureUI()
    }
    
    // MARK: - Configures
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(verticalStack1)
        verticalStack1.translatesAutoresizingMaskIntoConstraints = false
        verticalStack1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        verticalStack1.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        self.view.addSubview(self.verticalStack2)
        self.verticalStack2.translatesAutoresizingMaskIntoConstraints = false
        self.verticalStack2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.verticalStack2.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        verticalStack2.isHidden = true
        
        
    }
    
    func configure() {
        moveViewWhenKeyboardIsShown()
        dismissKeyboardWhenTappingAround()
        
    }
    
    // MARK: - Selectors
    
    @objc func verify() {
        guard let verifycode = self.verificationCodeTextField.text else { return }
        guard let phonenumber = self.phonenumber else { return }
        self.verifyButton.isEnabled = false
        self.verifyButton.setTitleColor(UIColor.systemGray2, for: UIControl.State.normal)
        self.verifyButton.layer.borderColor = UIColor.systemGray2.cgColor
        
        
        
        VerificationService.shared.verify(phoneNumber: phonenumber, verificationCode: verifycode) { (error, errorMessage, verification) in
            if let message = errorMessage {
                self.renderPopupWithOkayButtonNoImage(title: "에러", message: message)
                self.verifyButton.isEnabled = true
                self.verifyButton.setTitleColor(UIColor.systemBlue, for: UIControl.State.normal)
                self.verifyButton.layer.borderColor = UIColor.systemBlue.cgColor
                return
            }
            
            if let error = error {
                self.renderPopupWithOkayButtonNoImage(title: "에러", message: error.localizedDescription)
                self.verifyButton.isEnabled = true
                self.verifyButton.setTitleColor(UIColor.systemBlue, for: UIControl.State.normal)
                self.verifyButton.layer.borderColor = UIColor.systemBlue.cgColor
                return
            }
            
            // 인증 성공 다음페이지로 넘겨준다.
            let step2 = NewAccountStep2Controller(phoneNumber: phonenumber)
            self.navigationController?.pushViewController(step2, animated: true)
            
        }
        
        
    }
    
    @objc func requestVerificationCodeButtonTapped() {
        guard let phone1 = self.phoneTextField1.text else { return }
        guard let phone2 = self.phoneTextField2.text else { return }
        guard let phone3 = self.phoneTextField3.text else { return }
        let phone = phone1 + phone2 + phone3
        self.requestVerificationCodeButton.isEnabled = false
        self.requestVerificationCodeButton.setTitleColor(UIColor.systemGray2, for: UIControl.State.normal)
        self.requestVerificationCodeButton.layer.borderColor = UIColor.systemGray2.cgColor
        
        VerificationService.shared.requestVerificationCode(phoneNumber: phone) { (verification, error, errorMessage) in
            if let errorMessage = errorMessage {
                print("DEBUG: \(errorMessage)")
                self.renderPopupWithOkayButtonNoImage(title: "에러", message: errorMessage)
                self.requestVerificationCodeButton.isEnabled = true
                self.requestVerificationCodeButton.setTitleColor(UIColor.systemBlue, for: UIControl.State.normal)
                self.requestVerificationCodeButton.layer.borderColor = UIColor.systemBlue.cgColor
                return
            }
            
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
                self.renderPopupWithOkayButtonNoImage(title: "에러", message: error.localizedDescription)
                self.requestVerificationCodeButton.isEnabled = true
                self.requestVerificationCodeButton.setTitleColor(UIColor.systemBlue, for: UIControl.State.normal)
                self.requestVerificationCodeButton.layer.borderColor = UIColor.systemBlue.cgColor
                return
            }
            
            guard let verification = verification else { return }
            self.phonenumber = verification.phoneNumber
            
            self.verticalStack1.isHidden = true
            self.verticalStack2.isHidden = false 
            
            
            
        }
        
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        //your code
        if textField == self.phoneTextField1 {
            if textField.text?.count == 3 {
                self.phoneTextField2.becomeFirstResponder()
            }
        }
        
        if textField == self.phoneTextField2 {
            if textField.text?.count == 4 {
                self.phoneTextField3.becomeFirstResponder()
            }
        }
        
        if textField == self.phoneTextField3 {
            if textField.text?.count == 4 {
                self.phoneTextField3.endEditing(true)
            }
        }
        
        if textField == self.verificationCodeTextField {
            if textField.text?.count == 6 {
                self.verificationCodeTextField.endEditing(true)
            }
        }
    }
}

extension NewAccountStep1Controller:UITextFieldDelegate {
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.phoneTextField1 {
            guard let textFieldText = textField.text,
                    let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                        return false
                }
                let substringToReplace = textFieldText[rangeOfTextToReplace]
                let count = textFieldText.count - substringToReplace.count + string.count
            
                return count <= 3
        }
        
        if textField == self.phoneTextField2 || textField == self.phoneTextField3 {
            guard let textFieldText = textField.text,
                    let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                        return false
                }
                let substringToReplace = textFieldText[rangeOfTextToReplace]
                let count = textFieldText.count - substringToReplace.count + string.count
            
                return count <= 4
        }
        
        if textField == self.verificationCodeTextField {
            guard let textFieldText = textField.text,
                    let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                        return false
                }
                let substringToReplace = textFieldText[rangeOfTextToReplace]
                let count = textFieldText.count - substringToReplace.count + string.count
            
                return count <= 6
        }
        
        
        
        return true
    }
}
