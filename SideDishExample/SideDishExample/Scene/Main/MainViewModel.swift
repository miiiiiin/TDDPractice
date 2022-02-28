//
//  MainViewModel.swift
//  SideDishExample
//
//  Created by Running Raccoon on 2022/02/21.
//

import Action
import Foundation
import RxSwift
import RxDataSources

final class MainViewModel: CommonViewModel {
    
    private let disposeBag = DisposeBag()
    
    
    let fetchItems: AnyObserver<Void>
    var mainSections: Observable<[MainSection]>
    
    override init(title: String, sceneCoordinator: SceneCoordinatorType, sidedishUseCase: SidedishUseCase) {
  
//        fetching
//            .asObservable()
//            .flatMap({ sidedishUseCase.getSidedishItems() })
//            .flatMap({ sidedishUseCase.makeMainSection(sidedishItems: $0) })
//            .subscribe(onNext: items.onNext)
//            .disposed(by: disposeBag)
//
//        mainSections = items.asObservable()
        
        let fetching = PublishSubject<Void>()
        
        let items = PublishSubject<[MainSection]>()
        
        fetchItems = fetching.asObserver()
        
//        fetching
//            .asObservable()
//            .flatMap({ })
        
        super.init(title: title, sceneCoordinator: sceneCoordinator, sidedishUseCase: sidedishUseCase)
    }
}
