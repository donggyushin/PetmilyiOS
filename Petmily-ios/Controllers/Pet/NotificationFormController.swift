//
//  NotificationFormController.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/15.
//

import UIKit

class NotificationFormController: UIViewController {
    
    
    // MARK: Properties
    let notificationName:String
    
    let scrollView:UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        switch self.notificationName {
        case "Dirofilaria-immitis":
            label.text = "심장사상충 알림"
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
    init(notificationName:String) {
        self.notificationName = notificationName
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
    }
    
    // MARK: Configures
    func configureKeyboard() {
        dismissKeyboardWhenTappingAround()
        moveViewWhenKeyboardIsShown()
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
        loadingView.isHidden = true
        
    }
    
    // MARK: Selectors
    @objc func doneButtonTapped(sender:UIButton) {
        self.loadingView.isHidden = false
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
