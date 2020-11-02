//
//  NewAccountStep6Controller.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/28.
//

import UIKit

class NewAccountStep6Controller: UIViewController {
    
    // MARK: - Properties
    let userId:String
    let phoneNumber:String
    let password:String
    let nickname:String
    var profileImage:UIImage?
    
    var userBirthString:String = ""
    
    let picker = UIImagePickerController()
    
    let myPickerData:[String]
    let myPickerMonthData = Utilities.shared.generateMonths()
    let myPickerDayData = Utilities.shared.generateDays()
    
    var selectedGender:String?
    
    let userBirthPicker = UIPickerView()
    
    private lazy var UserBirthTextField:UITextField = {
        let tf = UITextField()
        
        userBirthPicker.delegate = self
        tf.placeholder = "생년월일을"
        tf.textAlignment = .center
        tf.inputView = userBirthPicker
        tf.font = UIFont.systemFont(ofSize: 20)
        return tf
    }()
    
    let userBirthdayMonthPicker = UIPickerView()
    
    private lazy var UserBirthdayMonthTextField:UITextField = {
        let tf = UITextField()
        
        userBirthdayMonthPicker.delegate = self
        tf.placeholder = "입력해주세요"
        tf.textAlignment = .center
        tf.inputView = userBirthdayMonthPicker
        tf.font = UIFont.systemFont(ofSize: 20)
        return tf
    }()
    
    let userBirthdayDayPicker = UIPickerView()
    private lazy var UserBirthdayDayTextField:UITextField = {
        let tf = UITextField()
        
        userBirthdayDayPicker.delegate = self
        tf.textAlignment = .center
        tf.inputView = userBirthdayDayPicker
        tf.font = UIFont.systemFont(ofSize: 20)
        return tf
    }()
    
    private lazy var BirthdayContainer:UIView = {
        let view = UIView()
        view.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.8).isActive = true
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(UserBirthTextField)
        UserBirthTextField.translatesAutoresizingMaskIntoConstraints = false
        UserBirthTextField.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.3).isActive = true
        UserBirthTextField.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        UserBirthTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        UserBirthTextField.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        
        view.addSubview(UserBirthdayMonthTextField)
        UserBirthdayMonthTextField.translatesAutoresizingMaskIntoConstraints = false
        UserBirthdayMonthTextField.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.3).isActive = true
        UserBirthdayMonthTextField.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        UserBirthdayMonthTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        UserBirthdayMonthTextField.leftAnchor.constraint(equalTo: UserBirthTextField.rightAnchor).isActive = true
        
        view.addSubview(UserBirthdayDayTextField)
        UserBirthdayDayTextField.translatesAutoresizingMaskIntoConstraints = false
        UserBirthdayDayTextField.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        UserBirthdayDayTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        UserBirthdayDayTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        UserBirthdayDayTextField.leftAnchor.constraint(equalTo: UserBirthdayMonthTextField.rightAnchor).isActive = true
        
        
        return view
    }()
    
    
    private lazy var profileImageView:TouchableUIImageView = {
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
    
    private lazy var UserProfileButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("프로필 이미지", for: UIControl.State.normal)
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        bt.addTarget(self, action: #selector(selectImage), for: UIControl.Event.touchUpInside)
        return bt
    }()
    

    
    private lazy var maleButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("남자", for: UIControl.State.normal)
        bt.heightAnchor.constraint(equalToConstant: 50).isActive = true
        bt.widthAnchor.constraint(equalToConstant: view.frame.width * 0.4).isActive = true
        bt.addTarget(self, action: #selector(selectGender), for: UIControl.Event.touchUpInside)
        bt.clipsToBounds = true
        bt.layer.cornerRadius = 10
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        bt.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        return bt
    }()
    
    private lazy var femaleButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("여자", for: UIControl.State.normal)
        bt.heightAnchor.constraint(equalToConstant: 50).isActive = true
        bt.widthAnchor.constraint(equalToConstant: view.frame.width * 0.4).isActive = true
        bt.addTarget(self, action: #selector(selectGender), for: UIControl.Event.touchUpInside)
        bt.clipsToBounds = true
        bt.layer.cornerRadius = 10
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        bt.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        return bt
    }()
    
    private lazy var buttonContainer:UIView = {
        let v = UIView()
        v.addSubview(maleButton)
        maleButton.translatesAutoresizingMaskIntoConstraints = false
        maleButton.topAnchor.constraint(equalTo: v.topAnchor).isActive = true
        maleButton.bottomAnchor.constraint(equalTo: v.bottomAnchor).isActive = true
        maleButton.leftAnchor.constraint(equalTo: v.leftAnchor).isActive = true
        
        v.addSubview(femaleButton)
        femaleButton.translatesAutoresizingMaskIntoConstraints = false
        femaleButton.topAnchor.constraint(equalTo: v.topAnchor).isActive = true
        femaleButton.rightAnchor.constraint(equalTo: v.rightAnchor).isActive = true
        femaleButton.bottomAnchor.constraint(equalTo: v.bottomAnchor).isActive = true
        femaleButton.leftAnchor.constraint(equalTo: maleButton.rightAnchor).isActive = true
        
        
        v.layer.cornerRadius = 10
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.systemBlue.cgColor
        return v
    }()
    
    private lazy var loadingView:LoadingView = {
        let view = LoadingView()
        return view
    }()
    
    
    private lazy var makeNewAccountButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.addTarget(self, action: #selector(startButtonTapped), for: UIControl.Event.touchUpInside)
        bt.setTitle("시작하기", for: UIControl.State.normal)
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        return bt
    }()
    
    
    
    
    
    // MARK: - Lifecycles
    
    init(userId:String, phoneNumber:String, password:String, nickname:String) {
        self.userId = userId
        self.phoneNumber = phoneNumber
        self.password = password
        self.nickname = nickname
        self.myPickerData = Utilities.shared.generateUserBirthList()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configure()
        
        renderPopupWithOkayButtonNoImage(title: "축하합니다!", message: "회원가입에 필요한 모든 정보를 입력하셨습니다!\n추가적인 정보를 더 입력하면 펫밀리가 더 좋은 서비스를 제공할 수 있게되요")
    }
    
    // MARK: - Configures
    func configureUI() {
        view.backgroundColor = .systemBackground

        
        view.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        profileImageView.isHidden = true
        
        view.addSubview(buttonContainer)
        buttonContainer.translatesAutoresizingMaskIntoConstraints = false
        buttonContainer.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 70).isActive = true
        buttonContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        
        view.addSubview(BirthdayContainer)
        BirthdayContainer.translatesAutoresizingMaskIntoConstraints = false
        BirthdayContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        BirthdayContainer.topAnchor.constraint(equalTo: buttonContainer.bottomAnchor, constant: 50).isActive = true
        
        view.addSubview(makeNewAccountButton)
        makeNewAccountButton.translatesAutoresizingMaskIntoConstraints = false
        makeNewAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70).isActive = true
        makeNewAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true 
        
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loadingView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        loadingView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        loadingView.isHidden = true
    }
    
    func configure() {
        dismissKeyboardWhenTappingAround()
        moveViewWhenKeyboardIsShown()
        self.picker.allowsEditing = true
        self.picker.delegate = self
    }
    // MARK: - Helpers
    func makeNewAccount() {
        // TODO: - 로딩창
        loadingView.isHidden = false
        
        
        // TODO: - 회원가입
        AuthService.shared.makeNewAccount(userId: self.userId, password: self.password, nickname: self.nickname, phoneNumber: self.phoneNumber, birth: self.UserBirthTextField.text, gender: self.selectedGender, profileImage: self.profileImageView.image) { (error, errorMessage, success) in
            if let errorMessage = errorMessage {
                self.renderPopupWithOkayButtonNoImage(title: "죄송합니다", message: errorMessage)
                self.loadingView.isHidden = true
                return
            }
            
            if let error = error {
                self.renderPopupWithOkayButtonNoImage(title: "죄송합니다", message: error.localizedDescription)
                self.loadingView.isHidden = true
                return
            }
            
            if success {
                // 회원가입 성공
                
                // TODO: - 로그인
                AuthService.shared.loginUser(userId: self.userId, password: self.password) { (error, errorMessage, success, token) in
                    if let errorMessage = errorMessage {
                        self.renderPopupWithOkayButtonNoImage(title: "죄송합니다", message: errorMessage)
                        self.loadingView.isHidden = true
                        return
                    }
                    if let error = error {
                        self.renderPopupWithOkayButtonNoImage(title: "죄송합니다", message: error.localizedDescription)
                        self.loadingView.isHidden = true
                        return
                    }
                    
                    if success {
                        guard let token = token else { return }
                        LocalData.shared.setting(key: "token", value: token)
                        // TODO: - 메인화면
                        self.dismiss(animated: true) {
                            Root.shared.root.configureTabBar()
                        }
                        
                    }
                    
                }
                
                
            }
        }
        
        
    }
    
    // MARK: - Selectors
    
    @objc func startButtonTapped() {
        var message = ""
        if self.profileImage == nil {
            message = message + "프로필 이미지, "
        }
        
        if self.selectedGender == nil {
            message = message + "성별, "
        }
        
        
        if self.userBirthString.count == 0 {
            message = message + "태어난 날, "
        }
        
        let index = message.lastIndex(of: ",") ?? message.endIndex
        message = String(message[..<index])
        
        if message.count == 0 {
            self.makeNewAccount()
        }else {
            // TODO: - 알러트
            let alert = UIAlertController(title: "다음과 같은 항목을 입력하지 않았습니다.\n그대로 진행하시겠습니까?", message: message, preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "네", style: .default, handler: { (_) in
                self.makeNewAccount()
            }))
            alert.addAction(UIAlertAction(title: "아니요", style: .cancel, handler: nil))

            self.present(alert, animated: true)
        }
        
    }
    
    @objc func selectImage(sender:UIButton) {
        self.present(self.picker, animated: true, completion: nil)
    }
    
    @objc func selectGender(sender:UIButton) {
        if let gender = sender.titleLabel?.text {
            self.selectedGender = gender
            
            if gender == "남자" {
                self.maleButton.backgroundColor = .systemBlue
                self.maleButton.tintColor = UIColor.white
                self.femaleButton.backgroundColor = .systemBackground
                self.femaleButton.tintColor = UIColor.systemBlue
            }else {
                self.femaleButton.backgroundColor = .systemBlue
                self.femaleButton.tintColor = UIColor.white
                self.maleButton.backgroundColor = .systemBackground
                self.maleButton.tintColor = UIColor.systemBlue
            }
        }
    }
    
}

extension NewAccountStep6Controller:UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return myPickerData.count
        }else if component == 1{
            return self.myPickerMonthData.count
        }else {
            return self.myPickerDayData.count
        }
        
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return myPickerData[row]
        }else if component == 1 {
            return myPickerMonthData[row]
        }else {
            return myPickerDayData[row]
        }
        
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            UserBirthTextField.text = myPickerData[row] + " 년"
            self.userBirthString += myPickerData[row] + " 년"
        }else if component == 1{
            UserBirthdayMonthTextField.text = myPickerMonthData[row] + " 월"
            self.userBirthString += " " + myPickerMonthData[row] + " 월"
        }else {
            UserBirthdayDayTextField.text = myPickerDayData[row] + " 일"
            self.userBirthString += " " + myPickerDayData[row] + " 일"
        }
        
        
        
    }
    
    
}

extension NewAccountStep6Controller:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var newImage:UIImage?
        
        if let image = info[.editedImage] as? UIImage {
            newImage = image
        }else if let image = info[.originalImage] as? UIImage {
            newImage = image
        }
        
        if newImage != nil {
            self.profileImageView.image = newImage
            self.profileImage = newImage
        }
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
}


extension NewAccountStep6Controller:TouchableUIImageViewProtocol {
    func touchableUIImageViewTapped() {
        self.present(self.picker, animated: true, completion: nil)
    }
    
    
}
