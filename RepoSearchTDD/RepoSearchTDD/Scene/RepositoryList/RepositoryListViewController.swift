//
//  RepositoryListViewController.swift
//  RepoSearchTDD
//
//  Created by Running Raccoon on 2022/02/15.
//

import Foundation
import UIKit
import RxSwift
import SnapKit

class RepositoryListViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    private let chooseLanguageButton = UIBarButtonItem(barButtonSystemItem: .organize, target: nil, action: nil)
    private let refreshControl = UIRefreshControl()

    var viewModel: RepositoryListViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
        
        refreshControl.sendActions(for: .valueChanged)
    }
    
    private func setupUI() {
        navigationItem.rightBarButtonItem = chooseLanguageButton

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.insertSubview(refreshControl, at: 0)
        tableView.register(RepositoryCell.classForCoder(), forCellReuseIdentifier: RepositoryCell.reuseIdentifier)
        
        [tableView].forEach(view.addSubview(_:))
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupRepositoryCell(_ cell: RepositoryCell, repository: RepositoryViewModel) {
        cell.selectionStyle = .none
        cell.setName(repository.name)
        cell.setDescription(repository.description)
        cell.setStarsCountTest(repository.starsCountText)
    }
    
    private func presentAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
    private func setupBindings() {
        
        viewModel.repositories
            .observe(on: MainScheduler.instance)
            .do(onNext: { [weak self] _ in
                self?.refreshControl.endRefreshing()
            })
            .bind(to: tableView.rx.items(cellIdentifier: RepositoryCell.reuseIdentifier, cellType: RepositoryCell.self)) { [weak self] (_, repo, cell) in
                self?.setupRepositoryCell(cell, repository: repo)
            }
            .disposed(by: disposeBag)
        
        viewModel.alertMessage
            .subscribe(onNext: { [weak self] in
                self?.presentAlert(message: $0)
            })
            .disposed(by: disposeBag)
        
        viewModel.title
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        refreshControl.rx.controlEvent(.valueChanged)
            .bind(to: viewModel.reload)
            .disposed(by: disposeBag)
        
        chooseLanguageButton.rx.tap
            .bind(to: viewModel.chooseLanguage)
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(RepositoryViewModel.self)
            .bind(to: viewModel.selectRepository)
            .disposed(by: disposeBag)
        
    }
}
