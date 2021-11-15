//
//  SearchRepositoryViewController.swift
//  LetsGitHubSearchPractice
//
//  Created by Running Raccoon on 2021/11/11.
//

import UIKit
import SnapKit
import Alamofire

class SearchRepositoryViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let iv = UIActivityIndicatorView()
        return iv
    }()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    var currentSearchRequest: DataRequest?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("searchrepo")
        
        setUpUI()
    }
    
    
    private func setUpUI(){
        
        self.definesPresentationContext = true
        
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.autocapitalizationType = .none
        
        self.navigationItem.searchController = self.searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        self.view.addSubview(tableView)
        self.tableView.addSubview(activityIndicatorView)
        
        
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.activityIndicatorView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    private func search(keyword: String) {
        
    }
    
}


extension SearchRepositoryViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            self.search(keyword: text)
        }
        self.searchController.dismiss(animated: true, completion: nil)
    }
}

extension SearchRepositoryViewController: UITableViewDelegate {
    
}

extension SearchRepositoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
        cell.textLabel?.text = "ddd"
        return cell
    }
}
