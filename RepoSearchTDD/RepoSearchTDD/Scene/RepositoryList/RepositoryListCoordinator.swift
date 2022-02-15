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
        
        viewModel.showLanguageList
            .flatMap { [weak self] _ -> Observable<String?> in
                guard let `self` = self else { return .empty() }
                return self.showLanguageList(on: viewController)
            }
            .filter { $0 != nil }
            .map { $0! }
            .bind(to: viewModel.setCurrentLanguage)
            .disposed(by: disposeBag)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return Observable.never()
    }
    
    private func showRepository(by url: URL, in navigationController: UINavigationController) {
        let safariViewController = SFSafariViewController(url: url)
        navigationController.pushViewController(safariViewController, animated: true)
    }
    
    private func showLanguageList(on rootViewController: UIViewController) -> Observable<String?> {
        let coordinator = LanguageListCoordinator(rootViewController: rootViewController)
        
        return coordinate(to: coordinator)
            .map { result in
                switch result {
                case .language(let language):
                    return language
                case .cancel:
                    return nil
                }
            }
    }
}
