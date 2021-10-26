//
//  MainViewController.swift
//  ReactorBlog
//
//  Created by Running Raccoon on 2021/10/26.
//

import Foundation
import UIKit
import RxSwift
import ReactorKit
import Then
import DropDown

class MainViewController: BaseViewController, ReactorKit.View {
    

    typealias Reactor = MainViewReactor
    
    let searchDropDown = DropDown()
    let filterDropDown = DropDown()
    
//    let refreshControl = RefreshControl()
    
    let searchField = UISearchBar().then {
        $0.placeholder = "검색하기"
        $0.returnKeyType = .default
        $0.enablesReturnKeyAutomatically = false
    }
    
//    lazy var tableView = UITableView(
//        frame: .zero,
//        style: .plain
//    ).then {
//        $0.register(Reusable.postCell)
//        $0.refreshControl = self.refreshControl
//    }
    
    lazy var tableView = UITableView(frame: .zero, style: .plain)
//        .then {
//            $0.refreshControl
//        }
    
    
    // MARK: - Init -
    
    init(reactor: Reactor) {
        super.init()
        self.reactor = reactor // ReactorKit.View
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        
        
    }

}

extension MainViewController {
    
    func bind(reactor: MainViewReactor) {
        
        // MARK: - ACTION -
        
        
    }
}

