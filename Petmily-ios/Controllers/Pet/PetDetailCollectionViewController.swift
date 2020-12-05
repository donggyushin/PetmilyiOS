//
//  PetDetailCollectionViewController.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/08.
//

import UIKit
import YPImagePicker

private let reuseIdentifier = "cell"
private let reuseIdentifierForHeader = "header"
private let reuseIdentifierForFooter = "footer"
private let reuseIdentifierForInfoFooter = "infofooter"


protocol PetDetailCollectionViewControllerDelegate: class {
    func didUploadPetPhotos()
    func updatePet()
}

class PetDetailCollectionViewController: UICollectionViewController {
    // MARK: - Properties
    weak var delegate:PetDetailCollectionViewControllerDelegate?
    
    var dailyInfo:DailyInfoModel?
    
    var imagePicker: ImagePicker!
    
    let petController:PetController
    
    var pet:PetModel {
        didSet {
            refreshCollectionView()
        }
    }
    var footerVisible = true
    var selectedCategory = "Photos" {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.collectionView.reloadData()
            }
        }
    }
    
    var favoritePhotos:[PetPhoto] = []
    
    private lazy var notificationButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("설정", for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(rightBarButtonItemTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    private lazy var favoriteCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    private lazy var circularUploadButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.widthAnchor.constraint(equalToConstant: 50).isActive = true
        bt.heightAnchor.constraint(equalToConstant: 50).isActive = true
        bt.setTitle("+", for: UIControl.State.normal)
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        bt.backgroundColor = .systemBlue
        bt.layer.cornerRadius = 25
        bt.setTitleColor(.white, for: UIControl.State.normal)
        if traitCollection.userInterfaceStyle == .dark {
            bt.layer.shadowColor = UIColor.white.cgColor
        }else {
            bt.layer.shadowColor = UIColor.black.cgColor
        }
        bt.layer.shadowOffset = CGSize(width: 0, height: 0)
        bt.layer.shadowRadius = 3
        bt.layer.shadowOpacity = 0.4
        bt.layer.masksToBounds = false
        bt.addTarget(self, action: #selector(uploadButtonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    
    private lazy var loadingView:LoadingView = {
        let lv = LoadingView()
        return lv
    }()
    
    private var picker:YPImagePicker?
    
    // MARK: Lifecycles
    init(pet:PetModel, petController:PetController) {
        self.pet = pet
        self.petController = petController
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureUI()
        configurePicker()
        configureUINavigation()
        configureCollectionViews()
        fetchDailyInfo()
   
    }
    
    // MARK: APIs
    func fetchDailyInfo() {
        DailyInfoService.shared.getRandomDailyInfo { (error, errorMessage, success, dailyInfo) in
            if let errorMessage = errorMessage {
                return self.renderPopupWithOkayButtonNoImage(title: "에러", message: errorMessage)
            }
            
            if let error = error {
                return self.renderPopupWithOkayButtonNoImage(title: "에러", message: error.localizedDescription)
            }
            
            if success {
                guard let dailyInfo = dailyInfo else { return }
                self.dailyInfo = dailyInfo
            }else {
                return self.renderPopupWithOkayButtonNoImage(title: "에러", message: "알 수 없는 에러 발생")
            }
        }
    }
    
    
    
    // MARK: Configures
    func configureUI(){
        
        view.addSubview(circularUploadButton)
        circularUploadButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        circularUploadButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        if(self.pet.photos.count == 0) {
            circularUploadButton.isHidden = true
        }else {
            circularUploadButton.isHidden = false
        }
        
    
        
        view.addSubview(loadingView)
        collectionView.backgroundColor = .systemBackground
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loadingView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        loadingView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        loadingView.isHidden = true
        
        
        
    }
    
    
    func configurePicker() {
        var config = YPImagePickerConfiguration()
        config.wordings.libraryTitle = "앨범"
        config.wordings.cameraTitle = "카메라"
        config.wordings.next = "다음"
        config.wordings.cancel = "취소"
        config.library.maxNumberOfItems = 8
        config.library.mediaType = YPlibraryMediaType.photo
        config.startOnScreen = YPPickerScreen.library
        self.picker = YPImagePicker(configuration: config)
        
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
    }
    
    func configureUINavigation(){
        navigationItem.backButtonTitle = self.pet.name
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.edit, target: self, action: #selector(rightBarButtonItemTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.notificationButton)
    }
    
    func configureCollectionViews(){
        self.collectionView!.register(PetProfileDetailHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: reuseIdentifierForHeader)
        self.collectionView!.register(PetProfileDetailFooterCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: reuseIdentifierForFooter)
        self.collectionView!.register(PetProfileDetailFooterSecondCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: reuseIdentifierForInfoFooter)
        self.collectionView!.register(PetImageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: Helpers
    func fetchPets() {
        self.delegate?.updatePet()
    }
    
    func showImagePicker(_ sender: UIButton) {
            self.imagePicker.present(from: sender)
        }
    
    func refreshCollectionView(){
        if self.pet.photos.count == 0 {
            self.footerVisible = true
            self.circularUploadButton.isHidden = true
        }else {
            self.footerVisible = false
            self.circularUploadButton.isHidden = false
        }
        
        for item in self.pet.photos {
            if item.favorite {
                self.favoritePhotos.append(item)
            }
        }
        
        self.collectionView.reloadData()
    }
    
    func uploadPhoto(){
        
        showImagePicker(self.circularUploadButton)
        
    }
    
    // MARK: Selectors
    @objc func rightBarButtonItemTapped(){
        
        let petSettingController = UINavigationController(rootViewController: PetSettingsController(pet: self.pet, petDetailCollectionViewController: self))
        petSettingController.modalPresentationStyle = .fullScreen
        present(petSettingController, animated: true, completion: nil)
    }
    
    @objc func uploadButtonTapped(){
        uploadPhoto()
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.selectedCategory == "Favorites" {
            return self.favoritePhotos.count
        }
        
        return self.pet.photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PetImageCell
        cell.delegate = self
        if self.selectedCategory == "Favorites" {
            cell.photo = self.favoritePhotos[indexPath.row]
        }else {
            cell.photo = self.pet.photos[indexPath.row]
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionFooter {
            
        
            
            if self.selectedCategory == "Favorites" {
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdentifierForInfoFooter, for: indexPath) as! PetProfileDetailFooterSecondCell
                footer.dailyInfo = self.dailyInfo
        
                return footer
            }
            

            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdentifierForFooter, for: indexPath) as! PetProfileDetailFooterCell
            footer.card.delegate = self
        
            return footer
        }
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdentifierForHeader, for: indexPath) as! PetProfileDetailHeaderCell
        header.pet = self.pet
        header.delegate = self
        return header
    }
 
}

extension PetDetailCollectionViewController:UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 3 - 2, height: self.view.frame.width / 3 - 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 230)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        
        if self.pet.photos.count == 0 && self.selectedCategory == "Photos" {
            
            return CGSize(width: view.frame.width, height: 400)
        }
        
        if self.selectedCategory == "Favorites" {
            if let dailyInfo = self.dailyInfo {
                let dailyInfoText = dailyInfo.text
                let stringHeight = dailyInfoText.height(withConstrainedWidth: self.view.frame.width - 40, font: UIFont.systemFont(ofSize: 17))
                return CGSize(width: view.frame.width, height: 200 + stringHeight)
                
            }
            return CGSize(width: view.frame.width, height: view.frame.height - 400)
        }
        
        return CGSize(width: 0, height: 0)
        
    }
}

extension PetDetailCollectionViewController:TouchableViewDelegate {
    func touchableUIViewTapped(sender:TouchableUIView) {
        
        showImagePicker(self.circularUploadButton)
        
        // 인스타그램 형식의 이미지 피커
//        guard let picker = self.picker else { return }
//
//        var photos:[UIImage] = []
//
//        picker.didFinishPicking { (items, _) in
//            for item in items {
//                switch item {
//                case .photo(p: let photo):
//                    photos.append(photo.image)
//                    break
//                default:
//                    break
//                }
//            }
//            picker.dismiss(animated: true, completion: nil)
//            FileService.shared.uploadImageFiles(images: photos) { (error, errorMessage, photourls) in
//                if let errorMessage = errorMessage {
//                    self.renderPopupWithOkayButtonNoImage(title: "에러", message: errorMessage)
//                    return
//                }
//
//                if let error = error {
//                    self.renderPopupWithOkayButtonNoImage(title: "에러", message: error.localizedDescription)
//                    return
//                }
//
//                guard let photourls = photourls else { return }
//
//                var petPhotos:[PetPhoto] = []
//
//                for photourl in photourls {
//                    let petPhoto = PetPhoto(dictionary: ["url": photourl])
//                    petPhotos.append(petPhoto)
//                }
//
//
//                PetService.shared.uploadPetPhotos(petId: self.pet._id, petPhotoUrls: photourls) { (error, errorMessage, success) in
//                    self.loadingView.isHidden = true
//                    if let errorMessage = errorMessage {
//                        return self.renderPopupWithOkayButtonNoImage(title: "에러", message: errorMessage)
//                    }
//
//                    if let error = error {
//                        return self.renderPopupWithOkayButtonNoImage(title: "에러", message: error.localizedDescription)
//                    }
//
//                    if success {
//                        self.delegate?.didUploadPetPhotos()
//                        return self.pet.photos = petPhotos + self.pet.photos
//                    }else {
//                        return self.renderPopupWithOkayButtonNoImage(title: "에러", message: "알 수 없는 에러가 발생하였습니다")
//                    }
//
//                }
//
//            }
//        }
//        self.loadingView.isHidden = false
//        present(picker, animated: true, completion: nil)
    }
}


extension PetDetailCollectionViewController:PetProfileDetailHeaderCellDelegate {
    func selectFavorite() {
        self.selectedCategory = "Favorites"
    }
    
    func selectPhotos() {
        self.selectedCategory = "Photos"
    }
    
    
}



extension PetDetailCollectionViewController:PetImageCellDelgate {
    func petImageCellTapped(petPhoto: PetPhoto) {
        let photoViewerController = UINavigationController(rootViewController: PhotoViewerController(petPhoto: petPhoto, pet: self.pet, petDetailCollectionViewController: self))
        photoViewerController.modalPresentationStyle = .fullScreen
        self.present(photoViewerController, animated: true, completion: nil)
    }
}



extension PetDetailCollectionViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        guard let image = image else { return }
        self.loadingView.isHidden = false
        FileService.shared.uploadImageFile(image: image) { (error, errorMessage, url) in
            self.loadingView.isHidden = true
            if let errorMessage = errorMessage {
                return self.renderPopupWithOkayButtonNoImage(title: "에러", message: errorMessage)
            }
            
            if let error = error {
                return self.renderPopupWithOkayButtonNoImage(title: "에러", message: error.localizedDescription)
            }
            
            guard let url = url else {
                return self.renderPopupWithOkayButtonNoImage(title: "에러", message: "이미지를 업로드하는데 실패하였습니다")
            }
            
            PetService.shared.uploadPetPhotos(petId: self.pet._id, petPhotoUrls: [url]) { (error, errorMessage, success, petPhotos) in
                if let errorMessage = errorMessage {
                    return self.renderPopupWithOkayButtonNoImage(title: "에러", message: errorMessage)
                }
                
                if let error = error {
                    return self.renderPopupWithOkayButtonNoImage(title: "에러", message: error.localizedDescription)
                }
                
                if success {
                    // 이미지 업로드 성공.
                    // 현재 뷰의 pet 객체 수정,
                    
                    self.pet.photos = petPhotos
                    
                    
                    // 부모 뷰의 petList 객체 수정
                    self.petController.fetchMyPets()
                    
                }else {
                    return self.renderPopupWithOkayButtonNoImage(title: "에러", message: "알 수 없는 에러가 발생하였습니다.")
                }
            }
            
        }
    }
}
