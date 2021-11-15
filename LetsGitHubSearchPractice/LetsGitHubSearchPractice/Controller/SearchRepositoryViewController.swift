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
    
    var repositoryService: RepositoryServiceProtocol!
    var urlOpener: URLOpenerProtocol!
    
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
    var repositories: [Repository] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    private func setLoading(_ isLoading: Bool) {
        if isLoading {
            self.activityIndicatorView.startAnimating()
            self.tableView.isHidden = true
        } else {
            self.activityIndicatorView.stopAnimating()
            self.tableView.isHidden = false
        }
    }
    
    private func cancelPreviousSearchRequest() {
        self.currentSearchRequest?.cancel()
    }
    
    private func search(keyword: String) {
        
        self.cancelPreviousSearchRequest()
        self.setLoading(true)
        
        self.currentSearchRequest = self.repositoryService.search(keyword: keyword, completionHandler: { [weak self] result in
            guard let `self` = self else { return }
            self.setLoading(false)
            
            switch result {
            case let .success(searchResult):
                self.setSearchResult(searchResult)
                
            case let .failure(error):
                self.showErrorAlert(error: error)
            }
        })
    }
    
    private func setSearchResult(_ searchResult: RepoSearchResult) {
        self.repositories = searchResult.items
        self.tableView.reloadData()
    }
    
    private func showErrorAlert(error: Error) {
        let alertController = UIAlertController(title: "⚠️", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func formattedStargazersCount(_ count: Int) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        guard let formattedCount = formatter.string(from: count as NSNumber) else { return nil }
        return "⭐️ \(formattedCount)"
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
        return self.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
        
        let repository = self.repositories[indexPath.row]
        cell.textLabel?.text = repository.name
        cell.detailTextLabel?.text = self.formattedStargazersCount(repository.stargazersCount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repository = self.repositories[indexPath.row]
        let urlString = "https://github.com/\(repository.fullName)"
        guard let url = URL(string: urlString) else { return }
        self.urlOpener.open(url, options: [:], completionHandler: nil)
    }
}
