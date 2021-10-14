//
//  LoadingIndicator.swift
//  GitHubTDD
//
//  Created by Running Raccoon on 2021/10/14.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIActivityIndicatorView {
    
    var showLoading: Binder<Bool> {
        return Binder(self.base) { indicator, isShow in
            if isShow {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                UIApplication.shared.beginIgnoringInteractionEvents()
                indicator.isHidden = false
                indicator.startAnimating()
            } else {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                UIApplication.shared.endIgnoringInteractionEvents()
                indicator.stopAnimating()
                indicator.isHidden = true
            }
        }
    }
}
