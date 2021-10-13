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
}

class SearchViewModel: HasDisposeBag, SearchViewModelType {
    
    let isLoading = PublishRelay<Bool>()
    let searchText = PublishRelay<String>()
    
    init() {
        
    }
}
