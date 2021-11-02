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
import SnapKit
import RxGesture
import ReusableKit
import RxViewController

class MainViewController: BaseViewController, ReactorKit.View {
    
    typealias Reactor = MainViewReactor
    
    // MARK: - Table View Cell -
    
    struct Reusable {
        static let contentCell = ReusableCell<ContentCell>()
    }
    
    struct Metric {
        static let tableViewCellHeight = 130.f
    }
    
    let searchDropDown = DropDown()
    let filterDropDown = DropDown()
    
    let refreshControl = RefreshControl()
    
    let searchField = UISearchBar().then {
        $0.placeholder = "검색하기"
        $0.returnKeyType = .default
        $0.enablesReturnKeyAutomatically = false
    }
    
    let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: nil, action: nil)
    
    lazy var tableView = UITableView(frame: .zero, style: .plain)
        .then {
            $0.register(Reusable.contentCell)
            $0.refreshControl = self.refreshControl
        }

    let tableHeader = TableHeaderView(frame: CGRect(x: 0, y: 0, width: .zero, height: 50))
    
    
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
        
        self.view.addSubview(self.tableView)
        self.tableView.tableHeaderView = self.tableHeader
        
        self.navigationItem.titleView = searchField
        self.navigationItem.rightBarButtonItem = searchButton
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }

}

extension MainViewController {
    
    func bind(reactor: MainViewReactor) {
        
        // MARK: - ACTION -
        
        self.refreshControl.rx.controlEvent([.valueChanged])
            .map { Reactor.Action.refresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.rx.viewDidLoad
            .map { Reactor.Action.loadSearchHistory }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.tableView.rx.reachedBottom
            .map { Reactor.Action.loadMore }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // searchField 텍스트 & reactor 액션 바인딩
        self.searchField.rx.text.orEmpty
            .map(Reactor.Action.updateSearchWord)
            .bind(to: reactor.action )
            .disposed(by: disposeBag)
        
        let searchButtonTap = self.searchButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .share()
        
        searchButtonTap
            .subscribe(onNext: { [weak self] in
                self?.searchField.resignFirstResponder()
            })
            .disposed(by: disposeBag)
        
        searchButtonTap
            .map { Reactor.Action.refresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.tableHeader.sortButton.rx.tap
            .subscribe(onNext: { [weak self] in
                let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                
                let titleAction = UIAlertAction(title: "Title", style: .default) { _ in
                    reactor.action.onNext(.updateSort(.titleAsc))
                }
                
                let dateAction = UIAlertAction(title: "DateTime", style: .default) { _ in
                    reactor.action.onNext(.updateSort(.recency))
                }
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                
                [titleAction, dateAction, cancelAction].forEach(actionSheet.addAction(_:))
                self?.present(actionSheet, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        
        // MARK: - State -
        
        reactor.state.map { $0.items }
            .distinctUntilChanged()
            .bind(to: self.tableView.rx.items) { tableView, indexPath, element in
                guard let cell = tableView.dequeue(Reusable.contentCell) else { return UITableViewCell() }
                cell.reactor = ContentCellReactor(post: element, provider: reactor.provider)
                return cell
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .bind(to: self.activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isRefreshing }
            .distinctUntilChanged()
            .bind(to: self.refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.query }
            .distinctUntilChanged()
            .map { $0 != "" }
            .bind(to: self.searchButton.rx.isEnabled)
//            .subscribe(onNext: { [weak self] query in
//                print("query check: \(query)")
//            })
            .disposed(by: disposeBag)
        
        
        // MARK: - TableView -
        
        self.tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        self.tableView.rx.itemSelected
            .bind(to: self.tableView.rx.deselectRow)
            .disposed(by: disposeBag)
        
        self.searchField.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.searchDropDown.show()
            })
            .disposed(by: disposeBag)
        
        self.searchField.rx.searchButtonClicked
            .subscribe(onNext: { [weak self] _ in
                self?.searchField.resignFirstResponder()
            })
            .disposed(by: disposeBag)
        
    }
}


extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Metric.tableViewCellHeight
    }
}
