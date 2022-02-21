//
//  Scene.swift
//  SideDishExample
//
//  Created by Running Raccoon on 2022/02/21.
//

import UIKit

enum Scene {
    case main(MainViewModel)
//    case detail(DetailViewModel)
}

extension Scene {    
    func instantiate() -> UIViewController {
        switch self {
        case .main(let viewModel):
            var vc = MainViewController()
            vc.bind(viewModel: viewModel)
            
            let navigationController = UINavigationController(rootViewController: vc)
            return navigationController
        }
    }
}
