//
//  PostPresaleFirstController.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/12/05.
//

import UIKit

class PostPresaleFirstController: UIViewController {
    
    // MARK: Properties
    var selectedPhoto:UIImage?
    
    var imagePicker:ImagePicker!
    
    private lazy var uploadPhotoView:UploadPhotoView = {
        let view = UploadPhotoView()
        view.delegate = self
        return view
    }()
    
    private lazy var imageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 6
        iv.clipsToBounds = true
        iv.heightAnchor.constraint(equalToConstant: self.view.frame.width - 60).isActive = true
        return iv
    }()
    
    private lazy var continueButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("진행하기", for: UIControl.State.normal)
        bt.layer.borderWidth = 1
        bt.layer.borderColor = UIColor.systemBlue.cgColor
        bt.layer.cornerRadius = 6
        bt.heightAnchor.constraint(equalToConstant: 50).isActive = true
        bt.addTarget(self, action: #selector(continueButtonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    private lazy var reselectButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("다른사진 선택", for: UIControl.State.normal)
        bt.layer.borderWidth = 1
        bt.layer.borderColor = UIColor.systemBlue.cgColor
        bt.layer.cornerRadius = 6
        bt.heightAnchor.constraint(equalToConstant: 50).isActive = true
        bt.addTarget(self, action: #selector(reselectButtonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    private lazy var imageViewContainer:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView, continueButton, reselectButton])
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    // MARK: Lifecycles
    init() {
        super.init(nibName: nil, bundle: nil)
        
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUI()
        configureImagePicker()
        configureNav()
    }
    
    // MARK: Configures
    func configureNav() {
        navigationItem.backButtonTitle = "이미지 선택"
    }
    func configureUI(){
        view.backgroundColor = .systemBackground
        view.addSubview(uploadPhotoView)
        uploadPhotoView.translatesAutoresizingMaskIntoConstraints = false
        uploadPhotoView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        uploadPhotoView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        uploadPhotoView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        uploadPhotoView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        
        view.addSubview(imageViewContainer)
        imageViewContainer.translatesAutoresizingMaskIntoConstraints = false
        imageViewContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageViewContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageViewContainer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        imageViewContainer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        imageViewContainer.isHidden = true
    }
    
    func configureImagePicker() {
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    // MARK: Selectors
    @objc func reselectButtonTapped(sender:UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    @objc func continueButtonTapped(sender:UIButton) {
        guard let image = self.selectedPhoto else { return }
        let secondController = PostPresaleSecondController(representativeImage: image)
        navigationController?.pushViewController(secondController, animated: true)
    }
    

}

extension PostPresaleFirstController:ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        guard let image = image else { return }
        print("이미지 선택 됨 \(image)")
        self.selectedPhoto = image
        self.uploadPhotoView.isHidden = true
        self.imageView.image = image
        self.imageViewContainer.isHidden = false
    }
}


extension PostPresaleFirstController:UploadPhotoViewProtocol {
    func touched(sender: UploadPhotoView) {
        self.imagePicker.present(from: sender)
    }
}
