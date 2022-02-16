//
//  PokemonListView.swift
//  PokemonExample
//
//  Created by Running Raccoon on 2022/02/16.
//

import Foundation
import UIKit
import SnapKit

class PokemonListView: UIView {
    let tableView = UITableView(frame: .zero, style: .plain)

    init() {
        super.init(frame: .zero)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
