//
//  RepositoryCell.swift
//  GitHubTDD
//
//  Created by Running Raccoon on 2021/10/13.
//

import Foundation
import UIKit

class RepositoryCell: UICollectionViewCell, NibForName {
    
    @IBOutlet var repositoryNameLabel: UILabel!
    @IBOutlet var ownerNameLabel: UILabel!
    @IBOutlet var starCountLabel: UILabel!
    @IBOutlet var forkCountLabel: UILabel!
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        self.backgroundColor = .gray
//    }
}
