//
//  SelectKindController.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/01.
//

import UIKit

let reuseIdentifierForKindView = "reuseIdentifierForKindView"

protocol SelectKindControllerDelegate:class {
    func setKind(kind:PetListModel )
}

class SelectKindController: UICollectionViewController {

    // MARK: - Properties
    weak var delegate:SelectKindControllerDelegate?
    let searchController = UISearchController(searchResultsController: nil)
    var kindDatas:[PetListModel] = [] {
        didSet {
            self.filteredKindDatas = kindDatas
        }
    }
    
    var filteredKindDatas:[PetListModel] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Lifecycles
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configure()
        
        PetListService.shared.fetchPetList { (error, errorString, success, petlist) in
            if let errorString = errorString {
                self.renderPopupWithOkayButtonNoImage(title: "에러", message: errorString)
            }
            
            if let error = error {
                self.renderPopupWithOkayButtonNoImage(title: "에러", message: error.localizedDescription)
            }
            
            if success == true {
                guard let petlist = petlist else { return }
                self.kindDatas = petlist
            }
        }
    }
    
    // MARK: - Configures
    func configureUI() {
        view.backgroundColor = .systemBackground
        collectionView.backgroundColor = .systemBackground
    }
    
    func configure() {
        
        collectionView.alwaysBounceVertical = true

        collectionView.register(KindView.self, forCellWithReuseIdentifier: reuseIdentifierForKindView)
        
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "품종을 검색해주세요"
        // 4
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true
    }
    
    // MARK: Collectionview
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filteredKindDatas.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierForKindView, for: indexPath) as! KindView
        cell.petKind = self.filteredKindDatas[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension SelectKindController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        if searchText.isEmpty {
            self.filteredKindDatas = self.kindDatas
        }else {
            let datas:[PetListModel] = self.kindDatas.filter { (petkind) -> Bool in
                return petkind.name.contains(searchText)
            }
            self.filteredKindDatas = datas
        }
    }
}

extension SelectKindController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 60)
    }
}

extension SelectKindController:KindViewDelegate {
    func cellSelected(petKind: PetListModel) {
        self.delegate?.setKind(kind: petKind)
        navigationController?.popViewController(animated: true)
    }
}
