//
//  PokemonDetailsView.swift
//  PokemonExample
//
//  Created by Running Raccoon on 2022/02/17.
//

import UIKit
import SnapKit

class PokemonDetailsView: UIView {
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.alignment = .center
        sv.axis = .vertical
        sv.spacing = 10
        return sv
    }()

    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    let nameLabel = UILabel()
    let abilitiesLabel = makeMultilineLabel()
    let typesLabel = makeMultilineLabel()
    let weightLabel = UILabel()
    let heightLabel = UILabel()

    init() {
        super.init(frame: .zero)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .white

        addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }

        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(abilitiesLabel)
        stackView.addArrangedSubview(typesLabel)
        stackView.addArrangedSubview(weightLabel)
        stackView.addArrangedSubview(heightLabel)
    }

    private static func makeMultilineLabel() -> UILabel {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }
}
