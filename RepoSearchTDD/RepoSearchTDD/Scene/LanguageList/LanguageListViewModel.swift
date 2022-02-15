//
//  LanguageListViewModel.swift
//  RepoSearchTDD
//
//  Created by Running Raccoon on 2022/02/15.
//

import Foundation
import RxSwift
import RxCocoa

class LanguageListViewModel {
    
    // MARK: - Inputs

    let selectLanguage: AnyObserver<String>
    let cancel: AnyObserver<Void>

    // MARK: - Outputs

    let languages: Observable<[String]>
    let didSelectLanguage: Observable<String>
    let didCancel: Observable<Void>
    
    init(githubService: GithubService = GithubService()) {
        self.languages = githubService.getLanguageList()
        
        let _selectedLanguage = PublishSubject<String>()
        self.selectLanguage = _selectedLanguage.asObserver()
        self.didSelectLanguage = _selectedLanguage.asObservable()
        
        let _cancel = PublishSubject<Void>()
        self.cancel = _cancel.asObserver()
        self.didCancel = _cancel.asObservable()
    }
}
