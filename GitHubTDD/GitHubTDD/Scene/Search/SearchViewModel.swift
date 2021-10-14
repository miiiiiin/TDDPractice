//
//  SearchViewModel.swift
//  GitHubTDD
//
//  Created by Running Raccoon on 2021/10/07.
//

import Foundation
import RxSwift
import RxCocoa

protocol SearchViewModelType {
    var isLoading: PublishRelay<Bool> { get }
    var searchText: PublishRelay<String> { get }
    var doSearch: PublishRelay<Void> { get }
}

class SearchViewModel: HasDisposeBag, SearchViewModelType {
    
    private let service: GithubServiceType
    
    let isLoading = PublishRelay<Bool>()
    let searchText = PublishRelay<String>()
    let doSearch = PublishRelay<Void>()
    
    private var _repositories: [Repository] = []
    
    init(service: GithubServiceType) {
        self.service = service
        
        let shareSearchText = searchText.share()
        
        doSearch
            .do(onNext: { [weak isLoading] _ in
                
                isLoading?.accept(true)
            })
            .withLatestFrom(shareSearchText)
            .flatMapLatest { [weak service, _repositories] text -> Single<SearchedRepositories> in
                return (service?.search(sortOption: SearchOption(query: text)) ?? .never())
                .debug("search repositories of Github")
                .catchError { error in
                    print("search error: \(error)")
                    return Single.just(SearchedRepositories(total_count: Int.max, incomplete_results: false, items: _repositories))
                }
            }
            .subscribe(onNext: { [weak self] result in
                guard let self = self else { return }
                self.isLoading.accept(false)
                self._repositories = result.items
                //section
            })
            .disposed(by: disposeBag)
    }
}
