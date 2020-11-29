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
    
    var imagePicker:ImagePicker!
    
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
        
        view.addSubview(editButton)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        editButton.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 60).isActive = true
        
        view.delegate = self
        return view
    }()
    
    
    // MARK: Lifecycles
    
    init(pet:PetModel) {
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
        configureNavBar()
        configureImagePicker()
    }
    
    // MARK: Configures
    func configureImagePicker() {
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: applyButton)
    }
    
    func configureUI(){
        view.backgroundColor = .systemBackground
        
        view.addSubview(changeProfilePhotoContainer)
        changeProfilePhotoContainer.translatesAutoresizingMaskIntoConstraints = false
        changeProfilePhotoContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        changeProfilePhotoContainer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        changeProfilePhotoContainer.widthAnchor.constraint(equalToConstant: 100).isActive = true
        changeProfilePhotoContainer.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        
    }
    
    // MARK: Helpers
    func selectPhotoFromLibrary(sender: UIView) {
        self.imagePicker.present(from: sender)
    }
    
    // MARK: Selectors
    @objc func changeProfileContainerTapped(sender:UIView){
        self.selectPhotoFromLibrary(sender: sender)
    }
    
    @objc func applyButtonTapped(sender: UIButton){
        print("적용 버튼 클릭")
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
    }
}
