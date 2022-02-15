//
//  RepositoryCell.swift
//  RepoSearchTDD
//
//  Created by Running Raccoon on 2022/02/15.
//

import UIKit
import SnapKit

class RepositoryCell: UITableViewCell {
    
    static let reuseIdentifier = "RepositoryCell"
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var starsCountLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        [nameLabel, descriptionLabel, starsCountLabel].forEach(contentView.addSubview(_:))
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.topMargin)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.topMargin)
            make.leading.equalTo(nameLabel.snp.trailing).offset(24)
            make.height.equalTo(16)
        }
        
        starsCountLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.equalTo(nameLabel)
            make.height.equalTo(18)
        }
    }
    
    func setName(_ name: String) {
        nameLabel.text = name
    }

    func setDescription(_ description: String) {
        descriptionLabel.text = description
    }

    func setStarsCountTest(_ starsCountText: String) {
        starsCountLabel.text = starsCountText
    }
}
