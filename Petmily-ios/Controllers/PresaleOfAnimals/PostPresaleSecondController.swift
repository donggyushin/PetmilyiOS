//
//  PostPresaleSecondController.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/12/06.
//

import UIKit

private let reuseIdentifier = "AddressCell"

class PostPresaleSecondController: UICollectionViewController {
    
    // MARK: Properties
    let representativeImage:UIImage
    
    var addresses:[NaverAddressModel] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    let searchController = UISearchController(searchResultsController: nil)

    // MARK: Lifecycles
    init(representativeImage:UIImage) {
        self.representativeImage = representativeImage
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setNavigationBackground()
        configureUI()
        configureSearchBar()
        configureCollectionView()
    }
    
    // MARK: Configures
    func configureUI() {
        view.backgroundColor = .systemBackground
        collectionView.backgroundColor = .systemBackground
    }
    
    func configureCollectionView() {
        self.collectionView!.register(AddressCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.alwaysBounceVertical = true
    }
    

    func configureSearchBar() {
        
        
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "지역을 입력해주세요"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = self.searchController
        definesPresentationContext = true
        
    }


    // MARK: UICollectionViewDataSource



    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.addresses.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AddressCell
    
        // Configure the cell
        cell.address = self.addresses[indexPath.row]
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    
   

}


extension PostPresaleSecondController:UICollectionViewDelegateFlowLayout {
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 140)
    }
}


extension PostPresaleSecondController:UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchKeyword = searchController.searchBar.text else { return }
        NaverAddressService.shared.searchAddressWithQuery(query: searchKeyword) { (error, errorMessage, success, addresses) in
            if let errorMessage = errorMessage {
                return self.renderPopupWithOkayButtonNoImage(title: "에러", message: errorMessage)
            }
            
            if let error = error {
                return self.renderPopupWithOkayButtonNoImage(title: "에러", message: error.localizedDescription)
            }
            
            if success {
                self.addresses = addresses
            }
            
        }
    }
}
