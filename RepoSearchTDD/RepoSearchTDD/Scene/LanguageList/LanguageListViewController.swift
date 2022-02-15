//
//  LanguageListViewController.swift
//  RepoSearchTDD
//
//  Created by Running Raccoon on 2022/02/15.
//

import UIKit
import RxSwift

class LanguageListViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    let disposeBag = DisposeBag()
    var viewModel: LanguageListViewModel!
    
    private let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
    }
    
    private func setupUI() {
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.title = "Choose a language"

        tableView.rowHeight = 48.0
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "LanguageCell")
        
        [tableView].forEach(view.addSubview(_:))
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupBindings() {
        
        viewModel.languages
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: "LanguageCell", cellType: UITableViewCell.self)) { (_, language, cell) in
                cell.textLabel?.text = language
                cell.selectionStyle = .none
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self)
            .bind(to: viewModel.selectLanguage)
            .disposed(by: disposeBag)
        
        cancelButton.rx.tap
            .bind(to: viewModel.cancel)
            .disposed(by: disposeBag)
    }
}
