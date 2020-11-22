//
//  NotificationFormController.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/15.
//

import UIKit


protocol NotificationFormDelegate:class {
    func toggleNotificationValue(notificationName:String, value:Bool)
}

class NotificationFormController: UIViewController {
    
    
    // MARK: Properties
    weak var delegate:NotificationFormDelegate?
    
    let notificationName:String
    let pet:PetModel
    
    
    let scrollView:UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    private lazy var cancleButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("알림 끄기", for: UIControl.State.normal)
        bt.setTitleColor(UIColor.systemRed, for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(cancleButtonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        switch self.notificationName {
        case "Dirofilaria-immitis":
            label.text = "심장사상충 알림"
            break
        case NotificationNameEnum.shared.helminthic:
            label.text = "구충제 알림"
            break
        default:
            label.text = "??"
        }
        return label
    }()
    
    private lazy var grayLine:GrayLineView = {
        let gv = GrayLineView()
        return gv
    }()
    
    private lazy var descriptionLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        switch self.notificationName {
        case "Dirofilaria-immitis":
            label.text = "실처럼 생긴 유충이 개와 고양이 폐동맥에 주로 기생하는 질병이에요. 주로 모기를 통해 전염되고 고양이보다는 강아지에게 훨씬 위험해요. 심하면 강아지를 사망하게 하며, 치료가 되더라도 후유증을 유발하는 매우 위험한 질병이지만 예방이 가능하기 때문에 예방과 정기 검사만 제대로 해주면 크게 문제되지는 않아요.\n\n심장 사상충을 가장 마지막으로 먹인 날, 혹은 가장 빠른 시일내에 먹일날을 입력해주면 심장사상충 약을 먹일 주기인 한달에 한 번씩 푸쉬 알림으로 반려동물의 심장사상충 먹일 날을 미리 알려드려요!"
            break
        case NotificationNameEnum.shared.helminthic:
            label.text = "반려견들에게 산책만큼 큰 즐거움이 또 있을까요? 하지만, 공원, 산 등 풀이 있는 곳으로 산책을 다녀온 뒤 각종 내외부 기생충에 감염될 수 있어 주의가 필요하답니다. 진드기와 같이 눈에 띄는 외부 기생충의 경우 직접 제거해줄 수 있지만, 눈에 보이지 않는 내부 기생충의 경우 심한 경우 혈관을 막아 반려견을 사망에까지 이르게 할 수 있어 매우 위험해요!\n구충제는 한 번 투약하고 마는 것이 아니라 주기적인 투약이 필요해요. 생후 4주가 지났다면 수의사에게 구충제 복용에 대해 상담하고 처방을 받는 것이 좋습니다.\n\n구충제를 가장 마지막으로 먹인 날, 혹은 가장 빠른 시일내에 먹일날을 입력해주시면 구충제를 먹일 주기인 한달에 한 번씩 푸쉬 알림으로 반려동물의 구충제 약을 먹일 날을 미리 알려드려요!"
            break
        default:
            label.text = "??"
            break
        }
        return label
    }()
    
    let years:[String] = Utilities.shared.generateUserBirthList()
    var selectedYear:String?
    private lazy var yearPicker = UIPickerView()
    private lazy var yearPickerTextField:UITextField = {
        let tf = UITextField()
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tf.inputView = yearPicker
        tf.placeholder = "년"
        yearPicker.delegate = self
        tf.textAlignment = .right
        return tf
    }()
    
    let months:[String] = Utilities.shared.generateMonths()
    var selectedMonth:String?
    private lazy var monthPicker = UIPickerView()
    private lazy var monthPickerTextField:UITextField = {
        let tf = UITextField()
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tf.inputView = monthPicker
        tf.placeholder = "월"
        monthPicker.delegate = self
        tf.textAlignment = .right
        return tf
    }()
    
    let days:[String] = Utilities.shared.generateDays()
    var selectedDay:String?
    private lazy var dayPicker = UIPickerView()
    private lazy var dayPickerTextField:UITextField = {
        let tf = UITextField()
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tf.inputView = dayPicker
        tf.placeholder = "일"
        dayPicker.delegate = self
        tf.textAlignment = .right
        return tf
    }()
    
    private lazy var grayLine2:GrayLineView = {
        let view = GrayLineView()
        return view
    }()
    
    private lazy var doneButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("완료", for: UIControl.State.normal)
        bt.layer.cornerRadius = 8
        bt.layer.borderWidth = 1
        bt.layer.borderColor = UIColor.systemBlue.cgColor
        bt.addTarget(self, action: #selector(doneButtonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    private lazy var loadingView:LoadingViewWithoutBackground = {
        let lv = LoadingViewWithoutBackground()
        return lv
    }()
    
    // MARK: Lifecycles
    init(notificationName:String, pet:PetModel) {
        self.notificationName = notificationName
        self.pet = pet
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUI()
        configureKeyboard()
        fetchNotification()
        configureNav()
    }
    
    // MARK: APIs
    func fetchNotification() {
        NotificationService.shared.findNotificationByPetIdAndNotificationName(petId: pet._id, notificationName: notificationName) { (error, errorMessage, success, notification) in
            self.loadingView.isHidden = true
            if let errorMessage = errorMessage {
                return self.renderPopupWithOkayButtonNoImage(title: "에러", message: errorMessage)
            }
            
            if let error = error {
                return self.renderPopupWithOkayButtonNoImage(title: "에러", message: error.localizedDescription)
            }
            
            if success {
                if let notification = notification {
                    
                    let calendar = Calendar.current
                    let year = calendar.component(Calendar.Component.year, from: notification.firstNotified)
                    let month = calendar.component(Calendar.Component.month, from: notification.firstNotified)
                    let day = calendar.component(Calendar.Component.day, from: notification.firstNotified)
                    
                    
                    self.selectedYear = String(year)
                    self.selectedMonth = String(month)
                    self.selectedDay = String(day)
                    
                    self.yearPickerTextField.text = "\(year) 년"
                    self.monthPickerTextField.text = "\(month) 월"
                    self.dayPickerTextField.text = "\(day) 일"
                }
            }else {
                self.renderPopupWithOkayButtonNoImage(title: "에러", message: "알 수 없는 에러 발생")
            }
        }
    }
    
    // MARK: Configures
    func configureKeyboard() {
        dismissKeyboardWhenTappingAround()
        moveViewWhenKeyboardIsShown()
    }
    
    func configureNav() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.cancleButton)
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        self.scrollView.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        scrollView.addSubview(grayLine)
        grayLine.translatesAutoresizingMaskIntoConstraints = false
        grayLine.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        grayLine.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        grayLine.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: grayLine.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        
        let textFieldStack = UIStackView(arrangedSubviews: [self.yearPickerTextField, self.monthPickerTextField, self.dayPickerTextField])
        textFieldStack.axis = .horizontal
        textFieldStack.distribution = .fillEqually
        scrollView.addSubview(textFieldStack)
        textFieldStack.translatesAutoresizingMaskIntoConstraints = false
        textFieldStack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textFieldStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        textFieldStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(grayLine2)
        grayLine2.translatesAutoresizingMaskIntoConstraints = false
        grayLine2.topAnchor.constraint(equalTo: textFieldStack.bottomAnchor, constant: 0).isActive = true
        grayLine2.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        grayLine2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        
        doneButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        doneButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loadingView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        loadingView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
    }
    
    // MARK: Selectors
    @objc func cancleButtonTapped(sender:UIButton) {
   
        
        // Loading
        self.loadingView.isHidden = false
        
        // Server 알림 끄기 요청
        NotificationService.shared.turnOffNotification(petId: self.pet._id, notificationName: self.notificationName) { (error, errorMessage, success) in
            if let errorMessage = errorMessage {
                return self.renderPopupWithOkayButtonNoImage(title: "에러", message: errorMessage)
            }
            if let error = error {
                return self.renderPopupWithOkayButtonNoImage(title: "에러", message: error.localizedDescription)
            }
            if success {
                // LocalStorage에도 알림값 False
                LocalData.shared.setting(key: self.notificationName, value: "false")
                // Loading 끄고 이전 화면으로 돌아가기
                // 이전 화면의 알림도 꺼준다.
                self.delegate?.toggleNotificationValue(notificationName: self.notificationName, value: false)
                self.loadingView.isHidden = true
                self.navigationController?.popViewController(animated: true)
            }else {
                return self.renderPopupWithOkayButtonNoImage(title: "에러", message: "알 수 없는 에러 발생")
            }
        }
        
        
        
    }
    @objc func doneButtonTapped(sender:UIButton) {
        guard let selectedYear = self.selectedYear else {
            return self.renderPopupWithOkayButtonNoImage(title: "알림", message: "년도를 입력해주세요")
        }
        guard let selectedMonth = self.selectedMonth else {
            return self.renderPopupWithOkayButtonNoImage(title: "알림", message: "월 을 입력해주세요")
        }
        guard let selectedDay = self.selectedDay else {
            return self.renderPopupWithOkayButtonNoImage(title: "알림", message: "일 을 입력해주세요")
        }
        self.loadingView.isHidden = false
        NotificationService.shared.createOrUpdateNotification(petId: self.pet._id, notificationName: self.notificationName, isOn: true, firstNotifiedYear: selectedYear, firstNotifiedMonth: selectedMonth, firstNotifiedDate: selectedDay, type: nil) { (error, errorMessage, success) in
            self.loadingView.isHidden = true
            if let errorMessage = errorMessage {
                return self.renderPopupWithOkayButtonNoImage(title: "에러", message: errorMessage)
            }
            
            if let error = error {
                return self.renderPopupWithOkayButtonNoImage(title: "에러", message: error.localizedDescription)
            }
            
            if success == false {
                self.renderPopupWithOkayButtonNoImage(title: "에러", message: "알 수 없는 에러 발생")
                return
            }
            
            LocalData.shared.setting(key: self.notificationName, value: "true")
            self.delegate?.toggleNotificationValue(notificationName: self.notificationName, value: true)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    
}


extension NotificationFormController:UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return self.years.count
        }
        
        if component == 1 {
            return self.months.count
        }
        if component == 2 {
            return self.days.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return self.years[row]
        }
        if component == 1 {
            return self.months[row]
        }
        if component == 2 {
            return self.days[row]
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            let selectedValue = self.years[row]
            self.selectedYear = selectedValue
            self.yearPickerTextField.text = "\(selectedValue) 년"
        }
        if component == 1 {
            let selectedValue = self.months[row]
            self.selectedMonth = selectedValue
            self.monthPickerTextField.text = "\(selectedValue) 월"
        }
        if component == 2 {
            let selectedValue = self.days[row]
            self.selectedDay = selectedValue
            self.dayPickerTextField.text = "\(selectedValue) 일"
        }
    }
    
    
}
