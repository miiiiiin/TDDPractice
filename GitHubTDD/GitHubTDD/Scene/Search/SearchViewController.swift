//
//  SearchViewController.swift
//  GitHubTDD
//
//  Created by Running Raccoon on 2021/10/07.
//

import Foundation
import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView()
        return cv
    }()
    
//    lazy var activityIndicator: UIActivityIndicatorView = {
//        let indicator = UIActivityIndicatorView()
//        indicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
//        indicator.isHidden = true
//        return indicator
//    }()
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.returnKeyType = .done
        searchBar.placeholder = "Search"
        return searchBar
    }()
    
    private let viewModel: SearchViewModel!
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("searchvc")
        setUp()
    }
    
    private func setUp() {
        navigationItem.titleView = searchBar
        activityIndicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        activityIndicator.isHidden = true
        
        [collectionView, activityIndicator].forEach(view.addSubview(_:))
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
