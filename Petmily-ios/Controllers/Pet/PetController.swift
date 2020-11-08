//
//  PetController.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/10/31.
//

import UIKit

private let reuseIdentifier = "PetCell"

class PetController: UIViewController {
    

    // MARK: Properties
    var petlist:[PetModel] = [] {
        didSet {
            self.loadingView.isHidden = true
            self.petCollectionView.reloadData()
            if self.petlist.count == 0 {
                self.notYetView.isHidden = false
            }else {
                self.addingButton.isHidden = false
            }
        }
    }
    
    private lazy var petCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = "반려동물"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var notYetView:NotYetPet = {
        let view = NotYetPet()
        view.delegate = self
        return view
    }()
    
    private lazy var loadingView:LoadingView = {
        let lv = LoadingView()
        return lv
    }()
    
    private lazy var addingButton:UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("+", for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 45)
        button.widthAnchor.constraint(equalToConstant: 60).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.layer.cornerRadius = 30
        button.backgroundColor = UIColor.systemBlue
        if traitCollection.userInterfaceStyle == .dark {
            button.layer.shadowColor = UIColor.white.cgColor
        }else {
            button.layer.shadowColor = UIColor.black.cgColor
        }
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowRadius = 3
        button.layer.shadowOpacity = 0.4
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(goToRegisterController), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    // MARK: - Lifecylces
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        
        configureNavigation()
        configureCollectionView()
        
        fetchMyPets()
        
        
    }
    
    // MARK: - Configures
    func configureUI() {
        clearNavigationBar()
        
        view.backgroundColor = .systemBackground
        view.addSubview(notYetView)
        notYetView.translatesAutoresizingMaskIntoConstraints = false
        notYetView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        notYetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70).isActive = true
        notYetView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8).isActive = true
        notYetView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        notYetView.isHidden = true
        
        
        view.addSubview(petCollectionView)
        petCollectionView.translatesAutoresizingMaskIntoConstraints = false
        petCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        petCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        petCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        petCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(addingButton)
        addingButton.translatesAutoresizingMaskIntoConstraints = false
        addingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        addingButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        addingButton.isHidden = true
        
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loadingView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        loadingView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
    }
    
    func configureCollectionView(){
        self.petCollectionView.delegate = self
        self.petCollectionView.dataSource = self
        
        self.petCollectionView.register(PetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func configureNavigation(){
        navigationItem.backButtonTitle = "반려동물"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        
    }
    
    // MARK: APIs
    func fetchMyPets() {
        PetService.shared.fetchMyPets { (error, errorMessage, success, petlist) in
            if let errorString = errorMessage {
                return self.renderPopupWithOkayButtonNoImage(title: "에러", message: errorString)
            }
            if let error = error {
                return self.renderPopupWithOkayButtonNoImage(title: "에러", message: error.localizedDescription)
            }
            if success == false {
                return self.renderPopupWithOkayButtonNoImage(title: "에러", message: "알 수 없는 에러가 발생하였습니다.")
            }
            guard let petlist = petlist else { return }
            self.petlist = petlist
        }
    }
    
    // MARK: - Selectors
    @objc func goToRegisterController() {
        let petRegisterViewController = PetRegisterViewController()
        petRegisterViewController.delegate = self
        
        navigationController?.pushViewController(petRegisterViewController, animated: true)
    }
    
    
}

extension PetController:NotYetPetProtocol {
    func notYetViewTapped() {
        
        let petRegisterViewController = PetRegisterViewController()
        petRegisterViewController.delegate = self
        
        navigationController?.pushViewController(petRegisterViewController, animated: true)
    }
    
}

extension PetController:PetRegisterViewControllerDelegate {
    func registerDone() {
        print("반려동물 등록완료")
        // TODO: - 나중에 여기서 반려동물들을 호출하는 함수를 한 번 호출해줘야함!
        self.loadingView.isHidden = false
        self.fetchMyPets()
    }
    
    
}


extension PetController:UICollectionViewDelegate {
    
}

extension PetController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.petlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PetCell
        cell.delegate = self
        let pet = self.petlist[indexPath.row]
        cell.pet = pet
        
        
        return cell
    }
    
    
}

extension PetController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 3, height: view.frame.width / 3 + 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
}



extension PetController:PetCellDelegate {
    func cellTapped(petCell: PetCell) {
//        let petDetailController = PetDetailController()
//        petDetailController.pet = petCell.pet
//        navigationController?.pushViewController(petDetailController, animated: true)
        guard let pet = petCell.pet else { return }
        let petDetailCollectionViewController = PetDetailCollectionViewController(pet: pet)
        navigationController?.pushViewController(petDetailCollectionViewController, animated: true)
    }
}
