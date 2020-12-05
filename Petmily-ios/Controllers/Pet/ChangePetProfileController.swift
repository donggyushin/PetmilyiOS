//
//  ChangePetProfileController.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/29.
//

import UIKit
import SDWebImage

class ChangePetProfileController: UIViewController {

    // MARK: Properties
    let pet:PetModel
    var petSettingsController:PetSettingsController?
    
    var imagePicker:ImagePicker!
    var changedImage:UIImage?
    var year:String?
    var month:String?
    var day:String?
    var gender:String = "male"
    
    
    private lazy var applyButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("적용", for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(applyButtonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    private lazy var profileImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .secondarySystemBackground
        iv.heightAnchor.constraint(equalToConstant: 90).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 90).isActive = true
        iv.layer.cornerRadius = 45
        iv.layer.masksToBounds = true
        if let url = URL(string: self.pet.photourl) {
            iv.sd_setImage(with: url, completed: nil)
        }
        
        return iv
    }()
    
    private lazy var editButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.widthAnchor.constraint(equalToConstant: 40).isActive = true
        bt.heightAnchor.constraint(equalToConstant: 18).isActive = true
        bt.layer.cornerRadius = 6
        bt.layer.borderWidth = 1
        bt.layer.borderColor = UIColor.systemBlue.cgColor
        bt.setTitle("Edit", for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(changeProfileContainerTapped), for: UIControl.Event.touchUpInside)
        
        return bt
    }()
    
    private lazy var changeProfilePhotoContainer:TouchableUIView = {
        let view = TouchableUIView()
        view.isUserInteractionEnabled = true
        view.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true

        
        view.delegate = self
        return view
    }()
    
    private lazy var nameLabel:UILabel = {
        let label = UILabel()
        label.text = self.pet.name
        return label
    }()
    
    private lazy var nameEditButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.widthAnchor.constraint(equalToConstant: 40).isActive = true
        bt.heightAnchor.constraint(equalToConstant: 18).isActive = true
        bt.layer.cornerRadius = 6
        bt.layer.borderWidth = 1
        bt.layer.borderColor = UIColor.systemBlue.cgColor
        bt.setTitle("Edit", for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(editButtonTapped), for: UIControl.Event.touchUpInside)
        
        return bt
    }()
    
    
    
    private lazy var birthLabel:UILabel = {
        let label = UILabel()
        let date = self.pet.birthDate
        let yearText = DateUtils.shared.getYearFromDate(date: date)
        let monthText = DateUtils.shared.getMonthFromDate(date: date)
        let dayText = DateUtils.shared.getDayFromDate(date: date)
        
        self.year = yearText
        self.month = monthText
        self.day = dayText
        
        label.text = "\(yearText)년 \(monthText)월 \(dayText)일 🎉"
        
        return label
    }()
    
    private lazy var birthEditButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.widthAnchor.constraint(equalToConstant: 40).isActive = true
        bt.heightAnchor.constraint(equalToConstant: 18).isActive = true
        bt.layer.cornerRadius = 6
        bt.layer.borderWidth = 1
        bt.layer.borderColor = UIColor.systemBlue.cgColor
        bt.setTitle("Edit", for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(editButtonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    private lazy var petkindLabel:UILabel = {
        let label = UILabel()
        label.text = self.pet.kind
        return label
    }()
    
    private lazy var petkindEditButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.widthAnchor.constraint(equalToConstant: 40).isActive = true
        bt.heightAnchor.constraint(equalToConstant: 18).isActive = true
        bt.layer.cornerRadius = 6
        bt.layer.borderWidth = 1
        bt.layer.borderColor = UIColor.systemBlue.cgColor
        bt.setTitle("Edit", for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(editButtonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    
    
    

    private lazy var maleButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("MALE", for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(genderButtonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    private lazy var femaleButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("FEMALE", for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(genderButtonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    private lazy var genderLine:UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.widthAnchor.constraint(equalToConstant: self.view.frame.width / 2 - 20).isActive = true
        view.backgroundColor = .systemBlue
        return view
    }()
    
    private lazy var loadingView:LoadingViewWithoutBackground = {
        let lv = LoadingViewWithoutBackground()
        return lv
    }()
    
    
    // MARK: Lifecycles
    
    init(pet:PetModel) {
        self.pet = pet
        
        let date = self.pet.birthDate
        self.year = DateUtils.shared.getYearFromDate(date: date)
        self.month = DateUtils.shared.getMonthFromDate(date: date)
        self.day = DateUtils.shared.getDayFromDate(date: date)
        
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUI()
        configureNavBar()
        configureImagePicker()
        DispatchQueue.main.async {
            self.moveGenderLine(gender: self.gender)
        }
        
    }
    
    // MARK: Configures
    func configureImagePicker() {
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: applyButton)
        navigationItem.backButtonTitle = "프로필 변경"
    }
    
    func configureUI(){
        view.backgroundColor = .systemBackground
        
        view.addSubview(changeProfilePhotoContainer)
        changeProfilePhotoContainer.translatesAutoresizingMaskIntoConstraints = false
        changeProfilePhotoContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        changeProfilePhotoContainer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        changeProfilePhotoContainer.widthAnchor.constraint(equalToConstant: 100).isActive = true
        changeProfilePhotoContainer.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        view.addSubview(editButton)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.bottomAnchor.constraint(equalTo: changeProfilePhotoContainer.bottomAnchor, constant: 0).isActive = true
        editButton.leftAnchor.constraint(equalTo: changeProfilePhotoContainer.rightAnchor, constant: 3).isActive = true
        
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: changeProfilePhotoContainer.bottomAnchor, constant: 40).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        view.addSubview(nameEditButton)
        nameEditButton.translatesAutoresizingMaskIntoConstraints = false
        nameEditButton.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        nameEditButton.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 7).isActive = true

        
        view.addSubview(birthLabel)
        birthLabel.translatesAutoresizingMaskIntoConstraints = false
        birthLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        birthLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        view.addSubview(birthEditButton)
        birthEditButton.translatesAutoresizingMaskIntoConstraints = false
        birthEditButton.leftAnchor.constraint(equalTo: birthLabel.rightAnchor, constant: 7).isActive = true
        birthEditButton.bottomAnchor.constraint(equalTo: birthLabel.bottomAnchor).isActive = true
        
        view.addSubview(petkindLabel)
        petkindLabel.translatesAutoresizingMaskIntoConstraints = false
        petkindLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        petkindLabel.topAnchor.constraint(equalTo: birthLabel.bottomAnchor, constant: 20).isActive = true
        
        view.addSubview(petkindEditButton)
        petkindEditButton.translatesAutoresizingMaskIntoConstraints = false
        petkindEditButton.bottomAnchor.constraint(equalTo: petkindLabel.bottomAnchor).isActive = true
        petkindEditButton.leftAnchor.constraint(equalTo: petkindLabel.rightAnchor, constant: 7).isActive = true
        
        view.addSubview(maleButton)
        maleButton.translatesAutoresizingMaskIntoConstraints = false
        maleButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        maleButton.topAnchor.constraint(equalTo: petkindLabel.bottomAnchor, constant: 60).isActive = true
        maleButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2 - 20).isActive = true
        maleButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(femaleButton)
        femaleButton.translatesAutoresizingMaskIntoConstraints = false
        femaleButton.leftAnchor.constraint(equalTo: maleButton.rightAnchor).isActive = true
        femaleButton.topAnchor.constraint(equalTo: maleButton.topAnchor).isActive = true
        femaleButton.bottomAnchor.constraint(equalTo: maleButton.bottomAnchor).isActive = true
        femaleButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        view.addSubview(genderLine)
        genderLine.translatesAutoresizingMaskIntoConstraints = false
        genderLine.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        genderLine.topAnchor.constraint(equalTo: maleButton.bottomAnchor).isActive = true
        
        
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loadingView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        loadingView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        loadingView.isHidden = true
        
    }
    
    // MARK: Helpers
    
    func moveGenderLine(gender:String) {
        let move = self.view.frame.width / 2 - 20
        if self.gender == "male" && gender == "female" {
            UIView.animate(withDuration: 0.3) {
                self.genderLine.frame.origin.x += move
            }
            self.gender = "female"
        }else if self.gender == "female" && gender == "male" {
            UIView.animate(withDuration: 0.3) {
                self.genderLine.frame.origin.x -= move
            }
            self.gender = "male"
        }
    }
    
    func selectPhotoFromLibrary(sender: UIView) {
        self.imagePicker.present(from: sender)
    }
    
    // MARK: Selectors
    @objc func genderButtonTapped(sender:UIButton) {
        if sender == maleButton {
            moveGenderLine(gender: "male")
        }else if sender == femaleButton {
            moveGenderLine(gender: "female")
        }
        
    }
    
    @objc func editButtonTapped(sender:UIButton){
        if sender == nameEditButton {
            let changeNameLabelController = ChangePetNameController(text: self.pet.name)
            changeNameLabelController.delegate = self
            navigationController?.pushViewController(changeNameLabelController, animated: true)
        }
        
        if sender == birthEditButton {
            print("생일 변경 컨트롤러로 이동시키기")
            guard let year = self.year else { return }
            guard let month = self.month else { return }
            guard let day = self.day else { return }
            
            let changePetBirthdayController = ChangePetBirthdayController(year: year, month: month, day: day)
            changePetBirthdayController.delegate = self
            navigationController?.pushViewController(changePetBirthdayController, animated: true)
        }
        
        if sender == petkindEditButton {
            print("품종 변경 컨트롤러로 이동시키기")
            
            let selectKindController = SelectKindController()
            selectKindController.delegate = self
            navigationController?.pushViewController(selectKindController, animated: true)
        }
    }
    
    @objc func changeProfileContainerTapped(sender:UIView){
        self.selectPhotoFromLibrary(sender: sender)
    }
    
    @objc func applyButtonTapped(sender: UIButton){
        print("적용 버튼 클릭")
        loadingView.isHidden = false
        if changedImage != nil {
            // 이미지까지 같이 업데이트
            guard let imageToChange = self.profileImageView.image else { return }
            FileService.shared.uploadImageFile(image: imageToChange) { (error, errorMessage, imageUrl) in
                if let errorMessage = errorMessage {
                    return self.renderPopupWithOkayButtonNoImage(title: "에러", message: errorMessage)
                }
                
                if let error = error {
                    return self.renderPopupWithOkayButtonNoImage(title: "에러", message: error.localizedDescription)
                }
                
                guard let url = imageUrl else {
                    return self.renderPopupWithOkayButtonNoImage(title: "에러", message: "알 수 없는 에러 발생")
                }
                
                guard let name = self.nameLabel.text else { return }
                guard let year = self.year else { return }
                guard let month = self.month else { return }
                guard let day = self.day else { return }
                guard let kind = self.petkindLabel.text else { return }
                PetService.shared.updatePetProfile(petId: self.pet._id, petProfileImage: url, petName: name, petBirthYear: year, petBirthMonth: month, petBirthDay: day, petKind: kind, petGender: self.gender) { (error, errorMessage, success) in
                    
                    self.loadingView.isHidden = true
                    if let errorMessage = errorMessage { return self.renderPopupWithOkayButtonNoImage(title: "에러", message: errorMessage)}
                    if let error = error { return self.renderPopupWithOkayButtonNoImage(title: "에러", message: error.localizedDescription)}
                    if success == false { return self.renderPopupWithOkayButtonNoImage(title: "에러", message: "알 수 없는 에러 발생") }
                    
                    // 업데이트 완료
                    // 이제 뭘 해야하지?
                    // 반려동물 상세 페이지의 데이터를 업데이트 해준다.
                    self.petSettingsController?.petDetailCollectionViewController?.pet.name = name
                    self.petSettingsController?.petDetailCollectionViewController?.pet.kind = kind
                    self.petSettingsController?.petDetailCollectionViewController?.pet.photourl = url
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy/MM/dd"
                    let date = formatter.date(from: "\(year)/\(month)/\(day)")
                    self.petSettingsController?.petDetailCollectionViewController?.pet.birthDate = date!
                    self.petSettingsController?.petDetailCollectionViewController?.pet.gender = self.gender
                    // 반려동물 리스트 페이지에서 데이터를 다시 한번 api를 이용해서 fetch 해준다.
                    self.petSettingsController?.petDetailCollectionViewController?.fetchPets()
                    // 설정 페이지 자체를 dismiss 해줘서 바로 반려동물 상세 페이지로 이동시켜준다.
                    self.petSettingsController?.dismiss(animated: true, completion: nil)
                }
                
            }
        }else {
            // 기존 이미지의 Url 을 이용해서 업데이트
            guard let name = self.nameLabel.text else { return }
            guard let year = self.year else { return }
            guard let month = self.month else { return }
            guard let day = self.day else { return }
            guard let kind = self.petkindLabel.text else { return }
            PetService.shared.updatePetProfile(petId: self.pet._id, petProfileImage: self.pet.photourl, petName: name, petBirthYear: year, petBirthMonth: month, petBirthDay: day, petKind: kind, petGender: self.gender) { (error, errorMessage, success) in
                self.loadingView.isHidden = true
                if let errorMessage = errorMessage { return self.renderPopupWithOkayButtonNoImage(title: "에러", message: errorMessage)}
                if let error = error { return self.renderPopupWithOkayButtonNoImage(title: "에러", message: error.localizedDescription)}
                if success == false { return self.renderPopupWithOkayButtonNoImage(title: "에러", message: "알 수 없는 에러 발생") }
                
                // 업데이트 완료
                // 이제 뭘 해야하지?
                // 반려동물 상세 페이지의 데이터를 업데이트 해준다.
                self.petSettingsController?.petDetailCollectionViewController?.pet.name = name
                self.petSettingsController?.petDetailCollectionViewController?.pet.kind = kind
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy/MM/dd"
                let date = formatter.date(from: "\(year)/\(month)/\(day)")
                self.petSettingsController?.petDetailCollectionViewController?.pet.birthDate = date!
                self.petSettingsController?.petDetailCollectionViewController?.pet.gender = self.gender
                // 반려동물 리스트 페이지에서 데이터를 다시 한번 api를 이용해서 fetch 해준다.
                self.petSettingsController?.petDetailCollectionViewController?.fetchPets()
                // 설정 페이지 자체를 dismiss 해줘서 바로 반려동물 상세 페이지로 이동시켜준다.
                self.petSettingsController?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}


extension ChangePetProfileController:TouchableViewDelegate {
    func touchableUIViewTapped(sender: TouchableUIView) {
        self.selectPhotoFromLibrary(sender: sender)
    }
}


extension ChangePetProfileController:ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        guard let image = image else { return }
        print("이미지 선택됌 \(image)")
        self.profileImageView.image = image
        self.changedImage = image
    }
}


extension ChangePetProfileController:ChangePetNameControllerDelegate {
    func returnText(text: String, type:String) {
        if type == "name" {
            self.nameLabel.text = text
        }
    }
}


extension ChangePetProfileController:SelectKindControllerDelegate {
    func setKind(kind: PetListModel) {
        print("selected kind: \(kind)")
        self.petkindLabel.text = kind.name
    }
    
}


extension ChangePetProfileController:ChangePetBirthdayDelegate {
    func birthSelected(year: String, month: String, day: String) {
        self.birthLabel.text = "\(year)년 \(month)월 \(day)일 🎉"
        self.year = year
        self.month = month
        self.day = day
    }
    
}
