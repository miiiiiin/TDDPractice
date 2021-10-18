//
//  SearchViewController.swift
//  GitHubTDD
//
//  Created by Running Raccoon on 2021/10/07.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

class SearchViewController: UIViewController, HasDisposeBag, ViewModelBindableType {

    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
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
    
    let dataSource = RxCollectionViewSectionedAnimatedDataSource<RepositorySection> { ds, collectionView, indexPath, item in
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RepositoryCell.identifier, for: indexPath) as? RepositoryCell else { return UICollectionViewCell() }
        cell.repositoryNameLabel.text = item.name
        cell.forkCountLabel.text = "\(item.forks_count)"
        cell.ownerNameLabel.text = item.owner.login
        cell.starCountLabel.text = "\(item.stargazers_count)"
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("searchvc")
        setUp()
    }
    
    private func setUp() {
        view.backgroundColor = .white
        navigationItem.titleView = searchBar
        activityIndicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        activityIndicator.isHidden = true
        
        collectionView.register(RepositoryCell.nib, forCellWithReuseIdentifier: RepositoryCell.identifier)
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        [collectionView, activityIndicator].forEach(view.addSubview(_:))
        view.bringSubviewToFront(activityIndicator)
        
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
            .bind(to: activityIndicator.rx.showLoading)
            .disposed(by: disposeBag)
        
        searchBar.rx.text.orEmpty
            .distinctUntilChanged()
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked
            .do(onNext: { [weak searchBar] in
                searchBar?.resignFirstResponder()
            })
            .bind(to: viewModel.doSearch)
            .disposed(by: disposeBag)
        
        viewModel.section
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let collectionViewLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
        
        let sectionInset = collectionViewLayout.sectionInset
        let contentWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width
            - sectionInset.left
            - sectionInset.right
            - collectionView.contentInset.left
            - collectionView.contentInset.right
        
        return CGSize(width: contentWidth, height: 150)
    }
}
