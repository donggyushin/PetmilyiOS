//
//  ChangePetNameController.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/12/02.
//

import UIKit

protocol ChangePetNameControllerDelegate:class {
    func returnText(text:String, type:String)
}

class ChangePetNameController: UIViewController {

    // MARK: Properties
    weak var delegate:ChangePetNameControllerDelegate?
    var text:String
    
    private lazy var textInput:UITextField = {
        let tf = UITextField()
        tf.text = text
        tf.textAlignment = .center
        tf.delegate = self
        return tf
    }()
    
    private lazy var applyButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("적용", for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(applyButtonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    private lazy var textInputContainer:UIView = {
        let view = UIView()
        view.addSubview(textInput)
        textInput.translatesAutoresizingMaskIntoConstraints = false
        textInput.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        textInput.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        textInput.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        textInput.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        return view
    }()
    
    
    // MARK: Lifecycles
    init(text:String) {
        self.text = text
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moveViewWhenKeyboardIsShown()
        dismissKeyboardWhenTappingAround()

        // Do any additional setup after loading the view.
        
        configureUI()
        configureNav()
    }
    
    // MARK: Configures
    
    func configureNav() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: applyButton)
    }
    
    func configureUI(){
        view.backgroundColor = .systemBackground
        view.addSubview(textInputContainer)
        textInputContainer.translatesAutoresizingMaskIntoConstraints = false
        textInputContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textInputContainer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        textInputContainer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        textInputContainer.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    
    // MARK: Selectors
    @objc func applyButtonTapped(){
        guard let text = self.textInput.text else { return }
        delegate?.returnText(text: text, type:"name")
        navigationController?.popViewController(animated: true)
    }
    

}



extension ChangePetNameController:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == textInput {
            guard let text = textField.text else { return true }
            let newLength = text.count
            return newLength < 7
        }
        return true
    }
}
