//
//  PostPresaleFirstController.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/12/05.
//

import UIKit

class PostPresaleFirstController: UIViewController {
    
    // MARK: Properties
    private lazy var uploadPhotoView:UploadPhotoView = {
        let view = UploadPhotoView()
        view.delegate = self
        return view
    }()
    
    var imagePicker:ImagePicker!
    
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
    }
    
    // MARK: Configures
    func configureUI(){
        view.backgroundColor = .systemBackground
        view.addSubview(uploadPhotoView)
        uploadPhotoView.translatesAutoresizingMaskIntoConstraints = false
        uploadPhotoView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        uploadPhotoView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        uploadPhotoView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        uploadPhotoView.heightAnchor.constraint(equalToConstant: 250).isActive = true 
    }
    
    func configureImagePicker() {
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    

}

extension PostPresaleFirstController:ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        guard let image = image else { return }
        print("이미지 선택 됨 \(image)")
    }
}


extension PostPresaleFirstController:UploadPhotoViewProtocol {
    func touched(sender: UploadPhotoView) {
        self.imagePicker.present(from: sender)
    }
}
