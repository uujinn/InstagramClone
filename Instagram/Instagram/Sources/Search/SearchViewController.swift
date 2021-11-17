//
//  SearchViewController.swift
//  Instagram
//
//  Created by 양유진 on 2021/10/28.
//

import UIKit

class SearchViewController: UIViewController, UISearchResultsUpdating {

    let searchController = UISearchController(searchResultsController: TableViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else{
            return
        }
            
        print(text)
    }
}
