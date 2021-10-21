//
//  MainViewController.swift
//  MemeGen
//
//  Created by Running Raccoon on 2021/10/21.
//

import Foundation
import UIKit
import RxSwift

class MainViewController: UIViewController {
    
    @IBOutlet var displayImageView: UIImageView!
    @IBOutlet var clearButton: UIButton!
    @IBOutlet var tableView: UITableView!
    
    private let viewModel = MainViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bind()
    }
    
    
    private func bind() {
        
        viewModel.displayImage
            .asObservable()
            .observe(on: MainScheduler.instance)
            .bind(to: displayImageView.rx.image)
            .disposed(by: disposeBag)
        
        clearButton.rx.tap
            .bind(to: viewModel.onResetTap)
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .map { $0.row }
            .bind(to: viewModel.onThumbnailTap)
            .disposed(by: disposeBag)
    }
    
    private func configureTableView() {
        Observable.of(viewModel.thumbnails)
            .bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) {
                row, element, cell in
                cell.imageView?.image = element
            }
            .disposed(by: disposeBag)
        
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
    }
}
