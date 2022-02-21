//
//  CommonViewModel.swift
//  SideDishExample
//
//  Created by Running Raccoon on 2022/02/21.
//

import Foundation
import RxSwift
import RxCocoa

class CommonViewModel: NSObject {
    let title: Driver<String>
    let sceneCoordinator: SceneCoordinatorType
    let sidedishUseCase: SidedishUseCase
    
    init(title: String, sceneCoordinator: SceneCoordinatorType, sidedishUseCase: SidedishUseCase) {
        self.title = Observable.just(title).asDriver(onErrorJustReturn: "")
        self.sceneCoordinator = sceneCoordinator
        self.sidedishUseCase = sidedishUseCase
    }
}
