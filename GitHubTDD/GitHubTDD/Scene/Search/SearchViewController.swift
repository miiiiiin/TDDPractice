//
//  SearchViewController.swift
//  GitHubTDD
//
//  Created by Running Raccoon on 2021/10/07.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController, HasDisposeBag, ViewModelBindableType {

    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
//        cv.register(RepositoryCell.nib, forCellWithReuseIdentifier: RepositoryCell.identifier)
        return cv
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        indicator.isHidden = true
        return indicator
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.returnKeyType = .done
        searchBar.placeholder = "Search"
        return searchBar
    }()
    
    var viewModel: SearchViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("searchvc")
        setUp()
    }
    
    private func setUp() {
        navigationItem.titleView = searchBar
        activityIndicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        activityIndicator.isHidden = true
        
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        [collectionView, activityIndicator].forEach(view.addSubview(_:))
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func bindViewModel() {
        
        viewModel.isLoading
            .distinctUntilChanged()
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        searchBar.rx.text.orEmpty
            .distinctUntilChanged()
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)
        
        
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
}
