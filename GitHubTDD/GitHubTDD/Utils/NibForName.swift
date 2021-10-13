//
//  NibForName.swift
//  GitHubTDD
//
//  Created by Running Raccoon on 2021/10/13.
//

import Foundation
import UIKit

protocol NibForName: SwiftIdentifier {
    static var nib: UINib { get }
}

extension NibForName {
    static var nib: UINib {
        print("nibforname: \(Self.self), \(Self.nib)")
        return UINib(nibName: String(describing: Self.self), bundle: nil)
    }
}
