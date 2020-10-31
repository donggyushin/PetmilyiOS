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
        return tf
    }()
    
    private lazy var petNameView = ViewContainerWithImageIconAndUnderline(viewToAdd: self.petNameTextField, image: #imageLiteral(resourceName: "dog-collar 1").withRenderingMode(UIImage.RenderingMode.alwaysTemplate), width: view.frame.width * 0.8, height: 50, darkMode: isDarkMode, text: "이름")
    
    private lazy var petKindLabel:UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var petKind:ViewContainerWithImageIconAndUnderline = {
        let view = ViewContainerWithImageIconAndUnderline(viewToAdd: self.petKindLabel, image: #imageLiteral(resourceName: "icons8-pet-commands-summon-100 1").withRenderingMode(UIImage.RenderingMode.alwaysTemplate), width: self.view.frame.width, height: 50, darkMode: isDarkMode, text: "품종")
        let tap = UITapGestureRecognizer(target: self, action: #selector(sendToPetKindRegister))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    private lazy var birthdayImageView:UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "gift 1").withRenderingMode(UIImage.RenderingMode.alwaysTemplate))
        iv.heightAnchor.constraint(equalToConstant: 30).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 30).isActive = true
        if isDarkMode {
            iv.tintColor = .white
        }else {
            iv.tintColor = .black
        }
        return iv
    }()
    
    private lazy var birthdayImageViewContainer:UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        let label = UILabel()
        label.text = "생일"
        label.font = UIFont.systemFont(ofSize: 9)
        
        view.addSubview(birthdayImageView)
        birthdayImageView.translatesAutoresizingMaskIntoConstraints = false
//        birthdayImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        birthdayImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        birthdayImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        birthdayImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: birthdayImageView.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: birthdayImageView.bottomAnchor, constant: 8).isActive = true
        
        return view
    }()
    
    private lazy var petBirthdayPicker = UIPickerView()
    
    private lazy var birthdayYearTextField:UITextField = {
        let tf = UITextField()
        petBirthdayPicker.delegate = self
        tf.textAlignment = .center
        tf.inputView = petBirthdayPicker
        
        return tf
    }()
    
    private lazy var birthdayPickerView:TextContainer = {
        let tc = TextContainer(textField: birthdayYearTextField)
        
        return tc
    }()
    
    private lazy var petBirthMonthPicker = UIPickerView()
    
    private lazy var birthdayMonthTextField:UITextField = {
        let tf = UITextField()
        petBirthMonthPicker.delegate = self
        tf.textAlignment = .center
        tf.inputView = petBirthMonthPicker
        tf.widthAnchor.constraint(equalToConstant: view.frame.width * 0.28).isActive = true
        return tf
    }()
    
    private lazy var birthdayMonthPickerView:TextContainer = {
        let tc = TextContainer(textField: birthdayMonthTextField)
        
        return tc
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
        petImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        petImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        
        let yearLabel = UILabel()
        yearLabel.text = "년"
        
        let monthLabel = UILabel()
        monthLabel.text = "월"
        
        let stack2 = UIStackView(arrangedSubviews: [self.birthdayImageViewContainer, self.birthdayPickerView, yearLabel, self.birthdayMonthPickerView, monthLabel])
        stack2.spacing = 12
        stack2.axis = .horizontal
        stack2.distribution = .fill
        stack2.alignment = .bottom
        
        
        let stack1 = UIStackView(arrangedSubviews: [self.petNameView, self.petKind, stack2])
        stack1.axis = .vertical
        stack1.spacing = 30
        
        
        
        
        view.addSubview(stack1)
        stack1.translatesAutoresizingMaskIntoConstraints = false
        stack1.topAnchor.constraint(equalTo: petImageView.bottomAnchor, constant: 30).isActive = true
        stack1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stack1.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8).isActive = true
        
        
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
        if isDarkMode {
            self.birthdayImageView.tintColor = .white
        }else {
            self.birthdayImageView.tintColor = .black
        }
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
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == self.petBirthdayPicker {
            return self.petBirthdayData.count
        }else if pickerView == self.petBirthMonthPicker {
            return self.petBirthdayMonthData.count
        }
        return 0
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == self.petBirthdayPicker {
            return self.petBirthdayData[row]
        }else if pickerView == self.petBirthMonthPicker {
            return self.petBirthdayMonthData[row]
        }
        return ""
        
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == self.petBirthdayPicker {
            self.birthdayYearTextField.text = self.petBirthdayData[row]
        }else if pickerView == self.petBirthMonthPicker {
            self.birthdayMonthTextField.text = self.petBirthdayMonthData[row]
        }
        
        
    }
    
    
}
