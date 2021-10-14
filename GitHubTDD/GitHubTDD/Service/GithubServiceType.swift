//
//  GithubServiceType.swift
//  GitHubTDD
//
//  Created by Running Raccoon on 2021/10/14.
//

import Foundation
import RxSwift

protocol GithubServiceType: class {
    func search(sortOption: SearchOption) -> Single<SearchedRepositories>
}
