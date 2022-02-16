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
        super.init()
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
        
    }
}
