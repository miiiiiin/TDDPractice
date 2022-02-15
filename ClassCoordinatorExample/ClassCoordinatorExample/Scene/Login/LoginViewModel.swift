//
//  LoginViewModel.swift
//  ClassCoordinatorExample
//
//  Created by Running Raccoon on 2022/02/15.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel: BaseViewModel {
    
    typealias Dependencies = HasSceneCoordinator
    
    private let dependencies: Dependencies
    private let disposeBag = DisposeBag()
    
    // MARK: output
    
    let fetching = BehaviorSubject<Bool>(value: false)
    
    
    // MARK: initialization

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: methods

//    func authenticateWithRefresToken() -> Observable<Void> {
//        if CommandLine.arguments.contains("--stub-authentication") {
//            return Observable.empty()
//        }
//
//        fetching.onNext(true)
//        return dependencies.remoteConfigService.mockData.skip(1)
//            .flatMap { [weak self] mockData -> Observable<Bool> in
//                if mockData {
//                    return Observable.just(false)
//                }
//
//                self?.fetching.onNext(true)
//
//                self?.fetching.onNext(false)
//                return self?.dependencies.authService.authenticateWitRefreshToken().catchError { error in
//
//                    guard case AuthenticationError.invalidRefreshToken = error else {
//                        throw error
//                    }
//
//                    return Observable.just(false)
//                } ?? Observable.just(false)
//            }
//            .flatMap(postAuthSetup)
//    }
    
}
