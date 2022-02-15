//
//  RepositoryListViewModel.swift
//  RepoSearchTDD
//
//  Created by Running Raccoon on 2022/02/15.
//

import Foundation
import RxSwift

class RepositoryListViewModel {
    
    // MARK: - Inputs
    
    /// Call to update current language. Causes reload of the repositories.
    let setCurrentLanguage: AnyObserver<String>
    
    /// Call to show language list screen.
//    let chooseLanguage: AnyObserver<Void>
    
    /// Call to open repository page.
    //    let selectRepository: AnyObserver<RepositoryViewModel>
    
    /// Call to reload repositories.
    let reload: AnyObserver<Void>
    
    // MARK: - Outputs
    
    /// Emits an array of fetched repositories.
    let repositories: Observable<[RepositoryViewModel]>
    
    /// Emits a formatted title for a navigation item.
    let title: Observable<String>
    
    
    
    init(initialLanguage: String, githubService: GithubService = GithubService()) {
        
        let _reload = PublishSubject<Void>()
        self.reload = _reload.asObserver()
        
        let _currentLanguage = BehaviorSubject<String>(value: initialLanguage)
        self.setCurrentLanguage = _currentLanguage.asObserver()
        
        self.title = _currentLanguage.asObservable()
            .map { "\($0)" }
        
        self.repositories = Observable.combineLatest(_reload, _currentLanguage) { _, language in language }
            .flatMapLatest { language in
            githubService.getMostPopularRepositories(byLanguage: language)
                .catchError { error in
//                    _alertMessage.onNext(error.localizedDescription)
                    return Observable.empty()
                }
            }
            .map { repositories in repositories.map(RepositoryViewModel.init) }
        
    }
    
}
