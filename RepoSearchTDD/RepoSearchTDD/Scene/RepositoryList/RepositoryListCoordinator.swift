//
//  RepositoryListCoordinator.swift
//  RepoSearchTDD
//
//  Created by Running Raccoon on 2022/02/15.
//

import Foundation
import RxSwift
import SafariServices

class RepositoryListCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let viewModel = RepositoryListViewModel(initialLanguage: "Swift")
        let viewController = RepositoryListViewController()
        
        let navigationController = UINavigationController(rootViewController: viewController)

        viewController.viewModel = viewModel
        
        viewModel.showRepository
            .subscribe(onNext: { [weak self] in
                self?.showRepository(by: $0, in: navigationController) })
            .disposed(by: disposeBag)
        
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return Observable.never()
    }
    
    private func showRepository(by url: URL, in navigationController: UINavigationController) {
        let safariViewController = SFSafariViewController(url: url)
        navigationController.pushViewController(safariViewController, animated: true)
    }
}
