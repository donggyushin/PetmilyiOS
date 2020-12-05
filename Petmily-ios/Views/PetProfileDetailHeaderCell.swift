//
//  PetProfileDetailHeaderCell.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/08.
//

import UIKit
import SDWebImage

protocol PetProfileDetailHeaderCellDelegate:class {
    func selectFavorite()
    func selectPhotos()
}

class PetProfileDetailHeaderCell: UICollectionViewCell {
    
    // MARK: Properties
    weak var delegate:PetProfileDetailHeaderCellDelegate?
    var pet:PetModel? {
        didSet {
            configurePet()
        }
    }
    
    private lazy var profileImage:TouchableUIImageViewWithoutImage = {
        let iv = TouchableUIImageViewWithoutImage()
        iv.isUserInteractionEnabled = true
        iv.contentMode = .scaleAspectFill
        iv.widthAnchor.constraint(equalToConstant: 100).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 100).isActive = true
        iv.layer.cornerRadius = 50
        iv.clipsToBounds = true
        iv.backgroundColor = .secondarySystemBackground
        return iv
    }()
    
    private lazy var name:UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var genderIcon:UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    private lazy var nameContainer:UIView = {
        let view = UIView()
        view.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        name.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        view.addSubview(genderIcon)
        genderIcon.translatesAutoresizingMaskIntoConstraints = false
        genderIcon.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        genderIcon.leftAnchor.constraint(equalTo: name.rightAnchor, constant: 10).isActive = true
        
        return view
    }()
    
    private lazy var kind:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var birth:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "🎉"
        return label
    }()
    
    private var selectedButton = "Photos"
    
    private lazy var photosButton:UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("Photos", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(buttonTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    private lazy var favoriteButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("Daily Info", for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(buttonTapped), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    private lazy var selectedBar:UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 2).isActive = true
        view.backgroundColor = .systemBlue
        return view
    }()
    
    private lazy var buttonContainer:UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(photosButton)
        photosButton.translatesAutoresizingMaskIntoConstraints = false
        photosButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        photosButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        photosButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        photosButton.widthAnchor.constraint(equalToConstant: self.frame.width / 2).isActive = true
        
        view.addSubview(favoriteButton)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        favoriteButton.leftAnchor.constraint(equalTo: photosButton.rightAnchor).isActive = true
        favoriteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        favoriteButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        view.addSubview(selectedBar)
        selectedBar.translatesAutoresizingMaskIntoConstraints = false
        selectedBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        selectedBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        selectedBar.widthAnchor.constraint(equalToConstant: self.frame.width / 2).isActive = true
        return view
    }()
    
    private lazy var grayLine:UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    // MARK: - Lifecylces
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Configures
    func configureUI(){
        
        
        
        addSubview(profileImage)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        profileImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        
        let verticalStack = UIStackView(arrangedSubviews: [nameContainer, kind, birth])
        
        verticalStack.axis = .vertical
        verticalStack.spacing = 20
        addSubview(verticalStack)
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 60).isActive = true
        verticalStack.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 40).isActive = true
        
        addSubview(grayLine)
        grayLine.translatesAutoresizingMaskIntoConstraints = false
        grayLine.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        grayLine.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        grayLine.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(buttonContainer)
        buttonContainer.translatesAutoresizingMaskIntoConstraints = false
        buttonContainer.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        buttonContainer.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        buttonContainer.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
         
    }
    
    func configurePet() {
        guard let pet = self.pet else { return }
        if let url = URL(string: pet.photourl) {
            self.profileImage.sd_setImage(with: url, completed: nil)
        }
        
        self.name.text = pet.name
        self.kind.text = pet.kind
        
        let date = pet.birthDate
        
        let year = DateUtils.shared.getYearFromDate(date: date)
        let month = DateUtils.shared.getMonthFromDate(date: date)
        let day = DateUtils.shared.getDayFromDate(date: date)
        
        self.birth.text = "🎉 \(year)년 \(month)월 \(day)일"
        
        if pet.gender == "male" {
            self.genderIcon.image = #imageLiteral(resourceName: "icons8-male-96")
        }else {
            self.genderIcon.image = #imageLiteral(resourceName: "icons8-female-96")
        }
        
    }
    
    // MARK: Selectors
    @objc func buttonTapped(sender:UIButton) {
        if selectedButton == "Photos" && sender == self.favoriteButton {
            UIView.animate(withDuration: 0.3) {
                self.selectedBar.frame.origin.x += self.frame.width / 2
            }
            
            self.selectedButton = "Favorites"
            self.delegate?.selectFavorite()
        }else if selectedButton == "Favorites" && sender == self.photosButton {
            UIView.animate(withDuration: 0.3) {
                self.selectedBar.frame.origin.x -= self.frame.width / 2
            }
            
            self.selectedButton = "Photos"
            self.delegate?.selectPhotos()
        }
    }
    
}
