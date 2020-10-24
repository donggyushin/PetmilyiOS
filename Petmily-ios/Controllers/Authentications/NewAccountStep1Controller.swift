//
//  NewAccountStep1Controller.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/25.
//

import UIKit

class NewAccountStep1Controller:UIViewController {
    
    // MARK: - Properties
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
        tc.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return tc
    }()
    
    private lazy var phone2Container:TextContainer = {
        let tc = TextContainer(textField: phoneTextField2)
        tc.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return tc
    }()
    
    private lazy var phone3Container:TextContainer = {
        let tc = TextContainer(textField: phoneTextField3)
        tc.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return tc
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
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Configures
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        let phoneTextFieldStack = UIStackView(arrangedSubviews: [phone1Container, phone2Container, phone3Container])
        phoneTextFieldStack.axis = .horizontal
        phoneTextFieldStack.distribution = .fillEqually
        phoneTextFieldStack.spacing = 20
        view.addSubview(phoneTextFieldStack)
        phoneTextFieldStack.translatesAutoresizingMaskIntoConstraints = false
        phoneTextFieldStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        phoneTextFieldStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        phoneTextFieldStack.widthAnchor.constraint(equalToConstant: view.frame.width * 0.7).isActive = true
        
        view.addSubview(requestVerificationCodeButton)
        requestVerificationCodeButton.translatesAutoresizingMaskIntoConstraints = false
        requestVerificationCodeButton.topAnchor.constraint(equalTo: phoneTextFieldStack.bottomAnchor, constant: 20).isActive = true
        requestVerificationCodeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    // MARK: - Selectors
    
    @objc func requestVerificationCodeButtonTapped() {
        self.requestVerificationCodeButton.isEnabled = false
        self.requestVerificationCodeButton.setTitleColor(UIColor.systemGray2, for: UIControl.State.normal)
        self.requestVerificationCodeButton.layer.borderColor = UIColor.systemGray2.cgColor
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
        
        
        
        return true
    }
}
