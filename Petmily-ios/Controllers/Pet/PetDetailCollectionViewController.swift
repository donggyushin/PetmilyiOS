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


protocol PetDetailCollectionViewControllerDelegate: class {
    func didUploadPetPhotos()
}

class PetDetailCollectionViewController: UICollectionViewController {
    // MARK: - Properties
    weak var delegate:PetDetailCollectionViewControllerDelegate?
    var pet:PetModel {
        didSet {
            if self.pet.photos.count == 0 {
                self.footerVisible = true
            }else {
                self.footerVisible = false
            }
            
            for item in self.pet.photos {
                if item.favorite {
                    self.favoritePhotos.append(item)
                }
            }
            
            self.collectionView.reloadData()
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
    
    private lazy var favoriteCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private lazy var loadingView:LoadingView = {
        let lv = LoadingView()
        return lv
    }()
    
    private var picker:YPImagePicker?
    
    // MARK: Lifecycles
    init(pet:PetModel) {
        self.pet = pet
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

        
    }
    
    // MARK: Configures
    func configureUI(){
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
    }
    
    func configureUINavigation(){
        navigationItem.backButtonTitle = self.pet.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.compose, target: self, action: #selector(rightBarButtonItemTapped))
    }
    
    func configureCollectionViews(){
        self.collectionView!.register(PetProfileDetailHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: reuseIdentifierForHeader)
        self.collectionView!.register(PetProfileDetailFooterCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: reuseIdentifierForFooter)
        self.collectionView!.register(PetImageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: Selectors
    @objc func rightBarButtonItemTapped(){
        
        let petSettingController = UINavigationController(rootViewController: PetSettingsController(pet: self.pet))
        petSettingController.modalPresentationStyle = .fullScreen
        present(petSettingController, animated: true, completion: nil)
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
        
        if self.selectedCategory == "Favorites" {
            cell.photo = self.favoritePhotos[indexPath.row]
        }else {
            cell.photo = self.pet.photos[indexPath.row]
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionFooter {
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
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 230)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        if self.pet.photos.count == 0 {
            return CGSize(width: view.frame.width, height: 400)
        }
        
        return CGSize(width: 0, height: 0)
        
    }
}

extension PetDetailCollectionViewController:TouchableViewDelegate {
    func touchableUIViewTapped() {
        
        guard let picker = self.picker else { return }
        
        var photos:[UIImage] = []
        
        picker.didFinishPicking { (items, _) in
            for item in items {
                switch item {
                case .photo(p: let photo):
                    photos.append(photo.image)
                    break
                default:
                    break
                }
            }
            picker.dismiss(animated: true, completion: nil)
            FileService.shared.uploadImageFiles(images: photos) { (error, errorMessage, photourls) in
                if let errorMessage = errorMessage {
                    self.renderPopupWithOkayButtonNoImage(title: "에러", message: errorMessage)
                    return
                }
                
                if let error = error {
                    self.renderPopupWithOkayButtonNoImage(title: "에러", message: error.localizedDescription)
                    return
                }
                
                guard let photourls = photourls else { return }
                
                var petPhotos:[PetPhoto] = []
                
                for photourl in photourls {
                    let petPhoto = PetPhoto(dictionary: ["url": photourl])
                    petPhotos.append(petPhoto)
                }
                
                
                PetService.shared.uploadPetPhotos(petId: self.pet._id, petPhotoUrls: photourls) { (error, errorMessage, success) in
                    self.loadingView.isHidden = true
                    if let errorMessage = errorMessage {
                        return self.renderPopupWithOkayButtonNoImage(title: "에러", message: errorMessage)
                    }
                    
                    if let error = error {
                        return self.renderPopupWithOkayButtonNoImage(title: "에러", message: error.localizedDescription)
                    }
                    
                    if success {
                        self.delegate?.didUploadPetPhotos()
                        return self.pet.photos = petPhotos + self.pet.photos
                    }else {
                        return self.renderPopupWithOkayButtonNoImage(title: "에러", message: "알 수 없는 에러가 발생하였습니다")
                    }
                    
                }
                
            }
        }
        self.loadingView.isHidden = false
        present(picker, animated: true, completion: nil)
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
