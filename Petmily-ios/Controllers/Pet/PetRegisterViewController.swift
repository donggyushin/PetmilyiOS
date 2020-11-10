//
//  PetRegisterViewController.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/31.
//

import UIKit

protocol PetRegisterViewControllerDelegate:class {
    func registerDone()
}

class PetRegisterViewController: UIViewController {
    
    // MARK: - Properties
    weak var delegate:PetRegisterViewControllerDelegate?
    
    let petBirthdayData = Utilities.shared.generateUserBirthList()
    let petBirthdayMonthData = Utilities.shared.generateMonths()
    let petBirthdayDayData = Utilities.shared.generateDays()
    
    let imagePickerController = UIImagePickerController()
    
    var petImage:UIImage?
    var selectedGender:String?
    
    var petSort:String?
    var kind:String?
    var personality:[String]?
    
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
    
    
    private lazy var petKindLabel:UILabel = {
        let label = UILabel()
        label.text = "품종을 선택해주세요"
        label.textColor = .placeholderText
        return label
    }()
    
    private lazy var petKindLabelContainer:UIView = {
        let view = UIView()
        
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8).isActive = true
        
        view.addSubview(petKindLabel)
        petKindLabel.translatesAutoresizingMaskIntoConstraints = false
        petKindLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        petKindLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        petKindLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        petKindLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        
        let underline = UIView()
        underline.backgroundColor = .secondarySystemBackground
        underline.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.addSubview(underline)
        underline.translatesAutoresizingMaskIntoConstraints = false
        underline.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        underline.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        underline.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(sendToPetKindRegister))
        
        view.addGestureRecognizer(tap)
        
        
        return view
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
    
    private lazy var petBirthdayDayPicker = UIPickerView()
    
    private lazy var petBirthdayDayTextField:UITextField = {
        let tf = UITextField()
        petBirthdayDayPicker.delegate = self
        tf.inputView = petBirthdayDayPicker
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
        birthdayYearTextField.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.3).isActive = true
        
        
        
        
        view.addSubview(birthdayMonthTextField)
        birthdayMonthTextField.translatesAutoresizingMaskIntoConstraints = false
        birthdayMonthTextField.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        birthdayMonthTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        birthdayMonthTextField.leftAnchor.constraint(equalTo: birthdayYearTextField.rightAnchor).isActive = true
        birthdayMonthTextField.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.3).isActive = true
        
        
        view.addSubview(petBirthdayDayTextField)
        petBirthdayDayTextField.translatesAutoresizingMaskIntoConstraints = false
        
        petBirthdayDayTextField.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        petBirthdayDayTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        petBirthdayDayTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        petBirthdayDayTextField.leftAnchor.constraint(equalTo: birthdayMonthTextField.rightAnchor).isActive = true
        
        
        
        
        let underlineForYear = UIView()
        underlineForYear.backgroundColor = .secondarySystemBackground
        underlineForYear.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.addSubview(underlineForYear)
        underlineForYear.translatesAutoresizingMaskIntoConstraints = false
        underlineForYear.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        underlineForYear.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        underlineForYear.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        
        return view
    }()
    
    
    
    private lazy var maleButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("수컷", for: UIControl.State.normal)

        bt.layer.cornerRadius = 8
        
        bt.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        bt.widthAnchor.constraint(equalToConstant: view.frame.width * 0.4).isActive = true
        
        bt.addTarget(self, action: #selector(genderButtonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    private lazy var femaleButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("암컷", for: UIControl.State.normal)

        bt.layer.cornerRadius = 8
        bt.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        bt.widthAnchor.constraint(equalToConstant: view.frame.width * 0.4).isActive = true
        bt.addTarget(self, action: #selector(genderButtonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    private lazy var genderButtonView:UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemBlue.cgColor
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
    
    private lazy var doneButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("등록", for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(registPet), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    private lazy var loadingView:LoadingView = {
        let lv = LoadingView()
        return lv
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
        
        let verticalStack = UIStackView(arrangedSubviews: [ petNameTextContainer, petKindLabelContainer, birthdayContainer, genderButtonView])
        
        verticalStack.spacing = 40
        verticalStack.axis = .vertical
        
        
        view.addSubview(verticalStack)
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.topAnchor.constraint(equalTo: petImageView.bottomAnchor, constant: 40).isActive = true
        verticalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        verticalStack.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8).isActive = true
        
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loadingView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        loadingView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        loadingView.isHidden = true
        
    }
    
    func configure() {
        self.imagePickerController.allowsEditing = true
        self.imagePickerController.mediaTypes = ["public.image"]
        
        moveViewWhenKeyboardIsShown()
        dismissKeyboardWhenTappingAround()
        
        navigationItem.backButtonTitle = "이전"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: doneButton)
        
    }
    // MARK: - Overrides
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
    }
    
    // MARK: - Selectors
    
    @objc func registPet() {
        print("반려동물 등록하기")
        guard let petimage = self.petImage else {
            renderPopupWithOkayButtonNoImage(title: "에러", message: "이미지를 등록해주세요!")
            return
        }
        
        guard let selectedGender = self.selectedGender else {
            renderPopupWithOkayButtonNoImage(title: "에러", message: "성별을 입력해주세요!")
            return
        }
        
        guard let petname = self.petNameTextField.text else {
            renderPopupWithOkayButtonNoImage(title: "에러", message: "이름을 입력해주세요!")
            return
        }
        
        guard let birthdayYear = self.birthdayYearTextField.text, let birthdayMonth = self.birthdayMonthTextField.text, let birthdayDay = self.petBirthdayDayTextField.text else {
            renderPopupWithOkayButtonNoImage(title: "에러", message: "이름을 입력해주세요!")
            return
        }
        
        if birthdayYear.isEmpty || birthdayMonth.isEmpty || birthdayDay.isEmpty {
            renderPopupWithOkayButtonNoImage(title: "에러", message: "생년월일을 입력해주세요!")
            return
        }
        
        if petname.isEmpty {
            renderPopupWithOkayButtonNoImage(title: "에러", message: "이름을 입력해주세요!")
            return
        }
        
        if petKindLabel.textColor == UIColor.placeholderText {
            renderPopupWithOkayButtonNoImage(title: "에러", message: "품종을 등록해주세요!")
            return
        }
        
        if !Utilities.shared.regularExpressionCheckFunction(text: petname, regularExpress: Properties.petnameRegex) {
            renderPopupWithOkayButtonNoImage(title: "에러", message: "이름을 한글로 입력해주세요!")
            return
        }
        
        guard let kind = self.kind else {
            renderPopupWithOkayButtonNoImage(title: "에러", message: "품종을 등록해주세요!")
            return
        }
        
        let birth = birthdayYear + birthdayMonth + birthdayDay
        
        self.loadingView.isHidden = false
        
        FileService.shared.uploadImageFile(image: petimage) { (error, errorString, imageUrl) in
            if let errorString = errorString {
                return self.renderPopupWithOkayButtonNoImage(title: "에러", message: errorString)
            }
            if let error = error {
                return self.renderPopupWithOkayButtonNoImage(title: "에러", message: error.localizedDescription)
            }
            guard let imageUrl = imageUrl else {
                
                return self.renderPopupWithOkayButtonNoImage(title: "에러", message: "알 수 없는 에러 발생")
            }
            
            
            PetService.shared.postNewPet(petSort: self.petSort, name:petname, kind: kind, personality: self.personality, photourl: imageUrl, gender: selectedGender, birth: birth) { (error, errorMessage, success) in
                if let errorString = errorString {
                    return self.renderPopupWithOkayButtonNoImage(title: "에러", message: errorString)
                }
                if let error = error {
                    return self.renderPopupWithOkayButtonNoImage(title: "에러", message: error.localizedDescription)
                }
                if success == false {
                    print("여기인가")
                    return self.renderPopupWithOkayButtonNoImage(title: "에러", message: "알 수 없는 에러 발생")
                }
                // 새로운 반려동물 등록 성공. 성공했으니 이전페이지로 돌려준다.
                // TODO: - 이전 페이지로 돌려주고, 반려동물을 서버로부터 호출해주는 함수를 다시 한 번 호출한다.
                self.delegate?.registerDone()
                self.navigationController?.popViewController(animated: true)
            }
            
        }
        
    }
    
    @objc func genderButtonTapped(sender:UIButton) {
        if sender == self.maleButton {
            self.selectedGender = "male"
            self.maleButton.backgroundColor = .systemBlue
            self.maleButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
            self.femaleButton.backgroundColor = .systemBackground
            self.femaleButton.setTitleColor(UIColor.systemBlue, for: UIControl.State.normal)
        }else {
            self.selectedGender = "female"
            self.femaleButton.backgroundColor = .systemBlue
            self.femaleButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
            self.maleButton.backgroundColor = .systemBackground
            self.maleButton.setTitleColor(UIColor.systemBlue, for: UIControl.State.normal)
        }
    }
    
    @objc func sendToPetKindRegister() {
        
        dismissKeyboard()
        
        let selectPetKindController = SelectKindController()
        selectPetKindController.delegate = self
        navigationController?.pushViewController(selectPetKindController, animated: true)
        
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
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            return self.petBirthdayData.count
        }else if component == 1 {
            return self.petBirthdayMonthData.count
        }else{
            return self.petBirthdayDayData.count
        }
        
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            return self.petBirthdayData[row]
        }else if component == 1 {
            return self.petBirthdayMonthData[row]
        }else {
            return self.petBirthdayDayData[row]
        }
        
        
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            self.birthdayYearTextField.text = self.petBirthdayData[row] + " 년"
        }else if component == 1 {
            self.birthdayMonthTextField.text = self.petBirthdayMonthData[row] + " 월"
        }else {
            self.petBirthdayDayTextField.text = self.petBirthdayDayData[row] + " 일"
        }
        
    }
    
    
}

extension PetRegisterViewController:SelectKindControllerDelegate {
    func setKind(kind: PetListModel) {
        self.petKindLabel.text = kind.name
        if traitCollection.userInterfaceStyle == .dark {
            self.petKindLabel.textColor = .white
        }else {
            self.petKindLabel.textColor = .black
        }
        
        self.petSort = kind.petSort
        self.kind = kind.name
        self.personality = kind.personality
        
    }
    
    
}
