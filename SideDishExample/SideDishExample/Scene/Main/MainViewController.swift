//
//  MainViewController.swift
//  SideDishExample
//
//  Created by Running Raccoon on 2022/02/21.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxViewController

final class MainViewController: UIViewController, ViewModelBindableType {
    
    // MARK: - ViewModel
    
    var viewModel: MainViewModel!
    
    // MARK: - Properties
    
    lazy var mainTableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
        debugPrint("mainvc")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func configureTableView() {
        view.addSubview(mainTableView)
        
        mainTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
//        mainTableView.register(MainTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: MainTableViewHeaderView.className)
    }
    
    
    // MARK: - Bind
    
    func bindViewModel() {
        
    }
}
