//
//  SearchRepositoryViewController.swift
//  LetsGitHubSearchPractice
//
//  Created by Running Raccoon on 2021/11/11.
//

import UIKit

class SearchRepositoryViewController: UIViewController {
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("searchrepo")
        
        self.definesPresentationContext = true

        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.autocapitalizationType = .none

        self.navigationItem.searchController = self.searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
}


extension SearchRepositoryViewController: UISearchBarDelegate {
    
}
