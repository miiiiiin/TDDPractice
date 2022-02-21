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
    
    override init(title: String, sceneCoordinator: SceneCoordinatorType, sidedishUseCase: SidedishUseCase) {
        
        
        super.init(title: title, sceneCoordinator: sceneCoordinator, sidedishUseCase: sidedishUseCase)
    }
}
