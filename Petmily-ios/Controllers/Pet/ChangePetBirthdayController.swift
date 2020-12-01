//
//  ChangePetBirthdayController.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/12/02.
//

import UIKit

class ChangePetBirthdayController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: UIPickerViewDelegate, UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return self.yearPickerData.count
        }
        
        if component == 1 {
            return self.monthPickerData.count
        }
        
        if component == 2 {
            return self.dayPickerData.count
        }
        
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return self.yearPickerData[row]
        }
        
        if component == 1 {
            return self.monthPickerData[row]
        }
        
        if component == 2 {
            return self.dayPickerData[row]
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            let selectedYear = self.yearPickerData[row]
            self.yearTextField.text = selectedYear
            self.year = selectedYear
        }
        
        if component == 1{
            let selectedMonth = self.monthPickerData[row]
            self.monthTextField.text = selectedMonth
            self.month = selectedMonth
        }
        
        if component == 2 {
            let selectedDay = self.dayPickerData[row]
            self.dayTextField.text = selectedDay
            self.day = selectedDay
        }
    }
    

    // MARK: Properties
    var year:String
    var month:String
    var day:String
    
    let yearPickerData = Utilities.shared.generateUserBirthList()
    let monthPickerData = Utilities.shared.generateMonths()
    let dayPickerData = Utilities.shared.generateDays()
    
    private lazy var yearPicker = UIPickerView()
    
    private lazy var yearTextField:UITextField = {
        let tf = UITextField()
        tf.text = year
        tf.inputView = yearPicker
        yearPicker.delegate = self
        yearPicker.dataSource = self
        tf.widthAnchor.constraint(equalToConstant: self.view.frame.width / 3).isActive = true
        tf.textAlignment = .right
        return tf
    }()
    
    private lazy var yearLabel:UILabel = {
        let label = UILabel()
        label.text = "년"
        return label
    }()
    
    private lazy var monthPicker = UIPickerView()
    
    private lazy var monthTextField:UITextField = {
        let tf = UITextField()
        tf.text = month
        tf.inputView = monthPicker
        monthPicker.delegate = self
        monthPicker.dataSource = self
        tf.textAlignment = .right
        return tf
    }()
    
    private lazy var monthLabel:UILabel = {
        let label = UILabel()
        label.text = "월"
        return label
    }()
    
    private lazy var dayPicker = UIPickerView()
    
    private lazy var dayTextField:UITextField = {
        let tf = UITextField()
        tf.text = day
        tf.inputView = dayPicker
        dayPicker.delegate = self
        dayPicker.dataSource = self
        tf.textAlignment = .right
        return tf
    }()
    
    private lazy var dayLabel:UILabel = {
        let label = UILabel()
        label.text = "일"
        return label
    }()

    
    private lazy var textFieldsContainer:UIView = {
        let view = UIView()
        let textFieldWidth = (self.view.frame.width - 40) / 3 - 30
        
        
        view.addSubview(yearTextField)
        yearTextField.translatesAutoresizingMaskIntoConstraints = false
        yearTextField.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        yearTextField.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        yearTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        yearTextField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true

        view.addSubview(yearLabel)
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.leftAnchor.constraint(equalTo: yearTextField.rightAnchor, constant: 7).isActive = true
        yearLabel.centerYAnchor.constraint(equalTo: yearTextField.centerYAnchor).isActive = true
        
        
        view.addSubview(monthTextField)
        monthTextField.translatesAutoresizingMaskIntoConstraints = false
        monthTextField.leftAnchor.constraint(equalTo: yearLabel.rightAnchor, constant: 10).isActive = true
        monthTextField.centerYAnchor.constraint(equalTo: yearTextField.centerYAnchor).isActive = true
        monthTextField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        
        view.addSubview(monthLabel)
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        monthLabel.centerYAnchor.constraint(equalTo: monthTextField.centerYAnchor).isActive = true
        monthLabel.leftAnchor.constraint(equalTo: monthTextField.rightAnchor, constant: 7).isActive = true
        
        
        view.addSubview(dayTextField)
        dayTextField.translatesAutoresizingMaskIntoConstraints = false
        dayTextField.centerYAnchor.constraint(equalTo: monthTextField.centerYAnchor).isActive = true
        dayTextField.leftAnchor.constraint(equalTo: monthLabel.rightAnchor, constant: 10).isActive = true
        dayTextField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        
        view.addSubview(dayLabel)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.leftAnchor.constraint(equalTo: dayTextField.rightAnchor, constant: 7).isActive = true
        dayLabel.centerYAnchor.constraint(equalTo: monthTextField.centerYAnchor).isActive = true
 
        return view
    }()
    
    
    
    // MARK: Lifecycles
    init(year:String, month:String, day:String) {
        self.year = year
        self.month = month
        self.day = day
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureKeyboard()
        configureUI()
    }
    
    // MARK: Configures
    func configureKeyboard() {
        dismissKeyboardWhenTappingAround()
        moveViewWhenKeyboardIsShown()
    }
    
    func configureUI(){
        view.backgroundColor = .systemBackground
        
        view.addSubview(textFieldsContainer)
        textFieldsContainer.translatesAutoresizingMaskIntoConstraints = false
        textFieldsContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textFieldsContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true 
        textFieldsContainer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        textFieldsContainer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        textFieldsContainer.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
    }
    

}
