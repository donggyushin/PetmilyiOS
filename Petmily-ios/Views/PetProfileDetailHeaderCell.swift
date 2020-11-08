//
//  PetProfileDetailHeaderCell.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/08.
//

import UIKit
import SDWebImage

class PetProfileDetailHeaderCell: UICollectionViewCell {
    
    // MARK: Properties
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
        return label
    }()
    
    private lazy var birth:UILabel = {
        let label = UILabel()
        label.text = "🎉"
        return label
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
    }
    
    func configurePet() {
        guard let pet = self.pet else { return }
        if let url = URL(string: pet.photourl) {
            self.profileImage.sd_setImage(with: url, completed: nil)
        }
        
        self.name.text = pet.name
        self.kind.text = pet.kind
        let birthdayText = pet.birth.replacingOccurrences(of: " ", with: "")
        let res = birthdayText.components(separatedBy: CharacterSet(charactersIn: "년월일"))
        self.birth.text = "\(self.birth.text!) \(res[0])년 \(res[1])월 \(res[2])일"
        
        if pet.gender == "male" {
            self.genderIcon.image = #imageLiteral(resourceName: "icons8-male-96")
        }else {
            self.genderIcon.image = #imageLiteral(resourceName: "icons8-female-96")
        }
        
    }
    
}
