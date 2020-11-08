//
//  PetDetailController.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/08.
//

import UIKit

class PetDetailController: UIViewController {
    // MARK: - Properties
    var pet:PetModel?{
        didSet {
            self.configurePet()
        }
    }
    private lazy var scrollView:UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    private lazy var loadingView:LoadingView = {
        let lv = LoadingView()
        return lv
    }()
    
    private lazy var photo:TouchableUIImageViewWithoutImage = {
        let iv = TouchableUIImageViewWithoutImage()
        iv.isUserInteractionEnabled = true
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .secondarySystemBackground
        iv.widthAnchor.constraint(equalToConstant: 140).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 140).isActive = true
        iv.layer.cornerRadius = 70
        iv.clipsToBounds = true
        iv.delegate = self
        return iv
    }()
    
    private lazy var name:UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var kind:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var genderIcon:UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    private lazy var birthdayLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "🎉"
        return label
    }()
    
    private lazy var nameAndKindView:UIView = {
        let view = UIView()
        view.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        name.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        view.addSubview(kind)
        kind.translatesAutoresizingMaskIntoConstraints = false
        kind.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        kind.leftAnchor.constraint(equalTo: name.rightAnchor, constant: 10).isActive = true
        return view
    }()
    
    // MARK: Lifecycles
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUI()
    }
    
    // MARK: Configures
    func configurePet() {
        guard let pet = self.pet else { return }
        if let url = URL(string: pet.photourl) {
            self.photo.sd_setImage(with: url, completed: nil)
            self.loadingView.isHidden = true 
        }
        
        self.name.text = pet.name
        self.kind.text = pet.kind
        let birthdayText = pet.birth.replacingOccurrences(of: " ", with: "")
        let res = birthdayText.components(separatedBy: CharacterSet(charactersIn: "년월일"))
        self.birthdayLabel.text = "\(self.birthdayLabel.text!) \(res[0])년 \(res[1])월 \(res[2])일"
        
        if pet.gender == "male" {
            self.genderIcon.image = #imageLiteral(resourceName: "icons8-male-96")
        }else {
            self.genderIcon.image = #imageLiteral(resourceName: "icons8-female-96")
        }

    }
    
    func configureUI(){
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(photo)
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50).isActive = true
        photo.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        let namdAndKindStack = UIStackView(arrangedSubviews: [self.name, self.kind, self.genderIcon])
        namdAndKindStack.axis = .horizontal
        namdAndKindStack.spacing = 10
        namdAndKindStack.alignment = .bottom

        
        let nameAndKindStackAndBirthdayStackView = UIStackView(arrangedSubviews: [namdAndKindStack, self.birthdayLabel])
        nameAndKindStackAndBirthdayStackView.axis = .vertical
        nameAndKindStackAndBirthdayStackView.spacing = 20
        nameAndKindStackAndBirthdayStackView.alignment = .leading
        scrollView.addSubview(nameAndKindStackAndBirthdayStackView)
        nameAndKindStackAndBirthdayStackView.translatesAutoresizingMaskIntoConstraints = false
        nameAndKindStackAndBirthdayStackView.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 70).isActive = true
        nameAndKindStackAndBirthdayStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        nameAndKindStackAndBirthdayStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        
        

        
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loadingView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        loadingView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    // MARK: Helpers
    
    

}


extension PetDetailController:TouchableUIImageViewWithoutImageDelegate {
    func touchableUIImageViewWithoutImageTapped() {
        guard let pet = self.pet else { return }
        let petProfileImageViewController = PetProfileImageViewController(pet: pet)
        present(petProfileImageViewController, animated: true, completion: nil)
    }
}
