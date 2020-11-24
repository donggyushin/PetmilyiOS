//
//  PhotoViewerController.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/21.
//

import UIKit
import SDWebImage

class PhotoViewerController: UIViewController {

    // MARK: Properties
    let petPhoto:PetPhoto
    let pet:PetModel
    let petDetailCollectionViewController:PetDetailCollectionViewController
    
    
    private lazy var photo:UIImageView = {
        let iv = UIImageView()
        if let url = URL(string: self.petPhoto.url) {
            iv.sd_setImage(with: url, completed: nil)
        }
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private lazy var favoriteButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("즐겨찾기", for: UIControl.State.normal)
        bt.setTitleColor(UIColor.systemYellow, for: UIControl.State.normal)
        return bt
    }()
    
    private lazy var divider:GrayLineView = {
        let view = GrayLineView()
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    private lazy var deleteButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("삭제하기", for: UIControl.State.normal)
        bt.setTitleColor(UIColor.systemRed, for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(buttonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    private lazy var loadingView:LoadingViewWithoutBackground = {
        let view = LoadingViewWithoutBackground()
        return view
    }()
    
    // MARK: Lifecylces
    init(petPhoto:PetPhoto, pet:PetModel, petDetailCollectionViewController:PetDetailCollectionViewController) {
        self.petPhoto = petPhoto
        self.pet = pet
        self.petDetailCollectionViewController = petDetailCollectionViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureNavigationBar()
    }
    
    // MARK: Configures
    func configureUI(){
        view.backgroundColor = .systemBackground
        
        view.addSubview(photo)
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        photo.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        photo.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        photo.heightAnchor.constraint(equalToConstant: view.frame.height * 0.7).isActive = true
        
        view.addSubview(favoriteButton)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.topAnchor.constraint(equalTo: photo.bottomAnchor).isActive = true
        favoriteButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        favoriteButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        favoriteButton.heightAnchor.constraint(equalToConstant: view.frame.height * 0.1).isActive = true
        
        view.addSubview(divider)
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.topAnchor.constraint(equalTo: favoriteButton.bottomAnchor).isActive = true
        divider.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        divider.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        view.addSubview(deleteButton)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.topAnchor.constraint(equalTo: divider.bottomAnchor).isActive = true
        deleteButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        deleteButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: view.frame.height * 0.1).isActive = true
        
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loadingView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        loadingView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        loadingView.isHidden = true
    }
    
    func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target: self, action: #selector(downloadButtonTapped))
    }
    
    // MARK: Selectors
    @objc func buttonTapped(sender:UIButton){
        print("버튼 탭")
        if sender == self.deleteButton {
            self.showDeleteActionSheet()
        }
    }
    
    
    @objc func downloadButtonTapped(){
        print("다운로드 버튼 탭")
        
        let optionMenu = UIAlertController(title: nil, message: "사진을 다운로드 하시겠어요?", preferredStyle: UIAlertController.Style.actionSheet)
        let saveAction = UIAlertAction(title: "내려받기", style: UIAlertAction.Style.default) { (action) in
            self.downloadPhoto()
        }
        let cancleAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancleAction)
        self.present(optionMenu, animated: true, completion: nil)
        
        
    }
    
    @objc func downloadDone() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Helpers
    
    func showDeleteActionSheet() {
        print("사진 삭제하기 액션쉿 보여주기")
        let actionSheet = UIAlertController(title: nil, message: "정말로 사진을 삭제하시겠습니까?", preferredStyle: UIAlertController.Style.actionSheet)
        actionSheet.addAction(UIAlertAction(title: "네", style: .default , handler:{ (UIAlertAction)in
                
            self.deletePhoto()
            }))
        actionSheet.addAction(UIAlertAction(title: "아니오", style: .cancel , handler:{ (UIAlertAction)in
                print("유저가 취소 버튼 누름")
            }))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func downloadPhoto() {
        print("사진 다운 받기")
        guard let image = self.photo.image else { return }
        // 다운 다 받고 화면 내리기
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    func deletePhoto() {
        
        self.loadingView.isHidden = false
        PetService.shared.deletePetPhoto(petPhotoId: self.petPhoto._id, petId: self.pet._id) { (error, errorMessage, success, petPhotos) in
            self.loadingView.isHidden = true
            if let errorMessage = errorMessage {
                return self.renderPopupWithOkayButtonNoImage(title: "에러", message: errorMessage)
            }
            
            if let error = error {
                return self.renderPopupWithOkayButtonNoImage(title: "에러", message: error.localizedDescription)
            }
            
            if success {
                self.petDetailCollectionViewController.pet.photos = petPhotos
                self.petDetailCollectionViewController.petController.fetchMyPets()
                self.dismiss(animated: true, completion: nil)
            }else {
                self.renderPopupWithOkayButtonNoImage(title: "에러", message: "알 수 없는 에러 발생")
            }
        }
    }
    
}
