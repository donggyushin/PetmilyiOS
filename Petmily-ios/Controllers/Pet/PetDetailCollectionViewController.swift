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

class PetDetailCollectionViewController: UICollectionViewController {
    // MARK: - Properties
    let pet:PetModel
    var petImages:[String] = []
    var footerVisible = true
    
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
        
        configurePicker()

        self.collectionView!.register(PetProfileDetailHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: reuseIdentifierForHeader)
        self.collectionView!.register(PetProfileDetailFooterCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: reuseIdentifierForFooter)
        self.collectionView!.register(PetImageCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }
    
    // MARK: Configures
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


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.petImages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PetImageCell
    
    
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
        return header
    }


}

extension PetDetailCollectionViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        if footerVisible {
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
        }
        
        present(picker, animated: true, completion: nil)
    }
}
