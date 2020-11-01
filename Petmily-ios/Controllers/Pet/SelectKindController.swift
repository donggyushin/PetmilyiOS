//
//  SelectKindController.swift
//  Petmily-ios
//
//  Created by 신동규 on 2020/11/01.
//

import UIKit

class SelectKindController: UIViewController {

    // MARK: - Properties
    let searchController = UISearchController(searchResultsController: nil)
    
    
    // MARK: - Lifecycles
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
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "품종을 검색해주세요"
        // 4
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true
    }
    

}

extension SelectKindController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        print(searchText)
    }
    
    
}
