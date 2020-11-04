//
//  SelectKindController.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/01.
//

import UIKit

let reuseIdentifierForKindView = "reuseIdentifierForKindView"

class SelectKindController: UICollectionViewController {

    // MARK: - Properties
    let searchController = UISearchController(searchResultsController: nil)
    var kindDatas = ["1", "2", "3"]
    
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
    }
    
    // MARK: - Configures
    func configureUI() {
        view.backgroundColor = .systemBackground
        

    }
    
    func configure() {

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
        return self.kindDatas.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierForKindView, for: indexPath) as! KindView
        return cell
    }
    

}

extension SelectKindController: UISearchResultsUpdating {
    
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        print(searchText)
    }
    
    
}

extension SelectKindController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 60)
    }
}

