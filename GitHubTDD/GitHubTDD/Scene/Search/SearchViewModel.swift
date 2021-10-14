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
    var section: PublishRelay<[RepositorySection]> { get }
    var doSearch: PublishRelay<Void> { get }
}

class SearchViewModel: HasDisposeBag, SearchViewModelType {
    
    private let service: GithubServiceType
    private let scheduler: RxSchedulerType
    
    let isLoading = PublishRelay<Bool>()
    let searchText = PublishRelay<String>()
    let section = PublishRelay<[RepositorySection]>()
    let doSearch = PublishRelay<Void>()
    
    private var _repositories: [Repository] = []
    
    init(service: GithubServiceType, scheduler: RxSchedulerType) {
        self.service = service
        self.scheduler = scheduler
        
        let shareSearchText = searchText.share()
        
        doSearch
            .observe(on: scheduler.main)
            .do(onNext: { [weak isLoading] _ in
                
                isLoading?.accept(true)
            })
            .observe(on: scheduler.io)
            .withLatestFrom(shareSearchText)
            .flatMapLatest { [weak service, _repositories] text -> Single<SearchedRepositories> in
                return (service?.search(sortOption: SearchOption(q: text)) ?? .never())
                .debug("search repositories of Github")
                .catchError { error in
                    print("search error: \(error)")
                    return Single.just(SearchedRepositories(total_count: Int.max, incomplete_results: false, items: _repositories))
                }
            }
            .subscribe(onNext: { [weak self] result in
                guard let self = self else { return }
                print("subscribe: \(result)")
                self.isLoading.accept(false)
                self._repositories = result.items
                
                let section = [RepositorySection(header: "repositories", items: result.items)]
                self.section.accept(section)
            })
            .disposed(by: disposeBag)
    }
}
