//
//  PetRegisterViewController.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/31.
//

import UIKit

class PetRegisterViewController: UIViewController {
    
    // MARK: - Properties
    let petBirthdayData = Utilities.shared.generateUserBirthList()
    let petBirthdayMonthData = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    
    
    let imagePickerController = UIImagePickerController()
    
    var petImage:UIImage?
    var selectedGender:String?
    
    private lazy var petImageView:TouchableUIImageView = {
        let iv = TouchableUIImageView(image: #imageLiteral(resourceName: "5b7fdeab1900001d035028dc 1"))
        iv.widthAnchor.constraint(equalToConstant: 126).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 126).isActive = true
        iv.layer.cornerRadius = 63
        iv.clipsToBounds = true
        iv.delegate = self
        iv.isUserInteractionEnabled = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private lazy var petNameTextField:UITextField = {
        let tf = UITextField()
        tf.delegate = self
        tf.placeholder = "이름을 입력해주세요"
        return tf
    }()
    
    private lazy var petNameTextContainer:TextContainer = {
        let tc = TextContainer(textField: petNameTextField)
        return tc
    }()
    
    
    
    private lazy var petBirthdayPicker = UIPickerView()
    
    private lazy var birthdayYearTextField:UITextField = {
        let tf = UITextField()
        petBirthdayPicker.delegate = self
        tf.inputView = petBirthdayPicker
        tf.placeholder = "생년월일을"
        return tf
    }()
    
    private lazy var petBirthMonthPicker = UIPickerView()
    
    private lazy var birthdayMonthTextField:UITextField = {
        let tf = UITextField()
        petBirthMonthPicker.delegate = self
        tf.inputView = petBirthMonthPicker
        tf.placeholder = "입력해주세요"
        return tf
    }()
    
    
    private lazy var birthdayContainer:UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8).isActive = true
        
        view.addSubview(birthdayYearTextField)
        birthdayYearTextField.translatesAutoresizingMaskIntoConstraints = false
        birthdayYearTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        birthdayYearTextField.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        birthdayYearTextField.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        birthdayYearTextField.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.4).isActive = true
        
        let underlineForYear = UIView()
        underlineForYear.backgroundColor = .secondarySystemBackground
        underlineForYear.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.addSubview(underlineForYear)
        underlineForYear.translatesAutoresizingMaskIntoConstraints = false
        underlineForYear.leftAnchor.constraint(equalTo: birthdayYearTextField.leftAnchor).isActive = true
        underlineForYear.bottomAnchor.constraint(equalTo: birthdayYearTextField.bottomAnchor).isActive = true
        underlineForYear.rightAnchor.constraint(equalTo: birthdayYearTextField.rightAnchor).isActive = true
        
        view.addSubview(birthdayMonthTextField)
        birthdayMonthTextField.translatesAutoresizingMaskIntoConstraints = false
        birthdayMonthTextField.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        birthdayMonthTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        birthdayMonthTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        birthdayMonthTextField.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.4).isActive = true
        
        let underlineForMonth = UIView()
        underlineForMonth.backgroundColor = .secondarySystemBackground
        underlineForMonth.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.addSubview(underlineForMonth)
        underlineForMonth.translatesAutoresizingMaskIntoConstraints = false
        underlineForMonth.rightAnchor.constraint(equalTo: birthdayMonthTextField.rightAnchor).isActive = true
        underlineForMonth.bottomAnchor.constraint(equalTo: birthdayMonthTextField.bottomAnchor).isActive = true
        underlineForMonth.leftAnchor.constraint(equalTo: birthdayMonthTextField.leftAnchor).isActive = true
        
        
        return view
    }()
    
    
    
    private lazy var maleButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("수컷", for: UIControl.State.normal)
        bt.layer.borderWidth = 1
        bt.layer.borderColor = UIColor.systemBlue.cgColor
        bt.layer.cornerRadius = 8
        
        bt.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        bt.widthAnchor.constraint(equalToConstant: view.frame.width * 0.4).isActive = true
        return bt
    }()
    
    private lazy var femaleButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("암컷", for: UIControl.State.normal)
        bt.layer.borderWidth = 1
        bt.layer.borderColor = UIColor.systemBlue.cgColor
        bt.layer.cornerRadius = 8
        bt.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        bt.widthAnchor.constraint(equalToConstant: view.frame.width * 0.4).isActive = true
        return bt
    }()
    
    private lazy var genderButtonView:UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.addSubview(maleButton)
        maleButton.translatesAutoresizingMaskIntoConstraints = false
        maleButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        maleButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        maleButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        view.addSubview(femaleButton)
        femaleButton.translatesAutoresizingMaskIntoConstraints = false
        femaleButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        femaleButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        femaleButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        femaleButton.leftAnchor.constraint(equalTo: maleButton.rightAnchor).isActive = true
        
        return view
    }()
    

    
    // MARK: - Lifecycles
    init() {
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configure()
        self.imagePickerController.delegate = self
    }
    
    // MARK: - Configures
    func configureUI(){
        view.backgroundColor = .systemBackground
        
        view.addSubview(petImageView)
        petImageView.translatesAutoresizingMaskIntoConstraints = false
        petImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        petImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let verticalStack = UIStackView(arrangedSubviews: [ petNameTextContainer, birthdayContainer, genderButtonView])
        
        verticalStack.spacing = 40
        verticalStack.axis = .vertical
        
        
        view.addSubview(verticalStack)
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.topAnchor.constraint(equalTo: petImageView.bottomAnchor, constant: 20).isActive = true
        verticalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        verticalStack.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8).isActive = true
        
        
    }
    
    func configure() {
        self.imagePickerController.allowsEditing = true
        self.imagePickerController.mediaTypes = ["public.image"]
        
        moveViewWhenKeyboardIsShown()
        dismissKeyboardWhenTappingAround()
        
        navigationItem.backButtonTitle = "이전"
    }
    // MARK: - Overrides
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
    }
    
    // MARK: - Selectors
    @objc func sendToPetKindRegister() {
        print("품종 선택 컨트롤러로 이동하기")
        dismissKeyboard()
    }
    

}


extension PetRegisterViewController:TouchableUIImageViewProtocol {
    func touchableUIImageViewTapped() {
        // TODO: - 사진 가져오는 컨트롤러 호출하기
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
}

extension PetRegisterViewController:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
                let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                    return false
            }
            let substringToReplace = textFieldText[rangeOfTextToReplace]
            let count = textFieldText.count - substringToReplace.count + string.count
            return count <= 10
    }
}

extension PetRegisterViewController:UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var newImage:UIImage
        
        if let possibleImage = info[.editedImage] as? UIImage {
            newImage = possibleImage
        }else if let possibleImage = info[.originalImage] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }
        
        self.petImage = newImage
        self.petImageView.image = newImage
        dismiss(animated: true, completion: nil)
        
    }
}


extension PetRegisterViewController:UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            return self.petBirthdayData.count
        }else {
            return self.petBirthdayMonthData.count
        }
        
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            return self.petBirthdayData[row]
        }else {
            return self.petBirthdayMonthData[row]
        }
        
        
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            self.birthdayYearTextField.text = self.petBirthdayData[row] + " 년"
        }else {
            self.birthdayMonthTextField.text = self.petBirthdayMonthData[row] + " 월"
        }
        
    }
    
    
}