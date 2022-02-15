//
//  LanguageListCoordinator.swift
//  RepoSearchTDD
//
//  Created by Running Raccoon on 2022/02/15.
//

import UIKit
import RxSwift

/// Type that defines possible coordination results of the `LanguageListCoordinator`.
///
/// - language: Language was choosen.
/// - cancel: Cancel button was tapped.
enum LanguageListCoordinationResult {
    case language(String)
    case cancel
}

class LanguageListCoordinator: BaseCoordinator<LanguageListCoordinationResult> {
    
    private let rootViewController: UIViewController
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<LanguageListCoordinationResult> {
        let viewController = LanguageListViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let viewModel = LanguageListViewModel()
        viewController.viewModel = viewModel
        
        let language = viewModel.didSelectLanguage.map { CoordinationResult.language($0)}
        let cancel = viewModel.didCancel.map { _ in CoordinationResult.cancel }
        
        rootViewController.present(navigationController, animated: true)
        
        return Observable.merge(cancel, language)
            .take(1)
            .do(onNext: { [weak self] _ in self?.rootViewController.dismiss(animated: true) })
    }
}
