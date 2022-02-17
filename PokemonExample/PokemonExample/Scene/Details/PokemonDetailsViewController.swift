//
//  PokemonDetailsViewController.swift
//  PokemonExample
//
//  Created by Running Raccoon on 2022/02/17.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Nuke

class PokemonDetailsViewController: UIViewController {
    
    private let viewModel: PokemonDetailsViewModelType
    private let disposeBag = DisposeBag()
 
    init(title: String, viewModel: PokemonDetailsViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = PokemonDetailsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }

    private func bindViewModel() {
        guard let view = view as? PokemonDetailsView else {
            fatalError("Wrong PokemonDetailsViewController view class")
        }
        
        let output = viewModel.transform()
        
        output.imageUrl
            .asObservable()
            .bind(to: Binder(self, binding: { target, url in
                Nuke.loadImage(with: url, into: view.imageView)
            }))
            .disposed(by: disposeBag)
        
        output.name
            .drive(view.nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.abilities
            .drive(view.abilitiesLabel.rx.text)
            .disposed(by: disposeBag)

        output.types
            .drive(view.typesLabel.rx.text)
            .disposed(by: disposeBag)

        output.weight
            .drive(view.weightLabel.rx.text)
            .disposed(by: disposeBag)

        output.height
            .drive(view.heightLabel.rx.text)
            .disposed(by: disposeBag)

    }
}
