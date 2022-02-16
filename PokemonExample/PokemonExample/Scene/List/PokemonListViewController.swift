//
//  PokemonListViewController.swift
//  PokemonExample
//
//  Created by Running Raccoon on 2022/02/16.
//

import Foundation
import UIKit
import RxSwift

class PokemonListViewController: UIViewController {
    
    private let viewModel: PokemonListViewModelType
    
    private let cellIdentifier = "PokemonCell"
    private let bottomReachingOffset: CGFloat = 50
    private let disposeBag = DisposeBag()
    
    init(viewModel: PokemonListViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = PokemonListView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        guard let view = view as? PokemonListView else {
            fatalError("Wrong PokemonListViewController view class")
        }

        self.title = "Pokemons"

        view.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    private func bindViewModel() {
        guard let view = view as? PokemonListView else {
            fatalError("Wrong PokemonListViewController view class")
        }
        
        let listBottomReached = view.tableView.rx
            .reachedBottom(offset: bottomReachingOffset)
            .skip(1)
            .asDriver(onErrorJustReturn: ())
        
        let input = PokemonListViewModelInput(listBottomReached: listBottomReached)
        
        let output = viewModel.transform(input: input)
        
        output.pokemonList
            .asObservable()
            .bind(to: view.tableView.rx.items(cellIdentifier: cellIdentifier, cellType: UITableViewCell.self)) {
                (index, item: PokemonListItem, cell) in
                cell.textLabel?.text = item.name
            }
            .disposed(by: disposeBag)
    }
}
