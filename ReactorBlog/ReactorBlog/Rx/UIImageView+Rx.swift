//
//  UIImageView+Rx.swift
//  ReactorBlog
//
//  Created by Running Raccoon on 2021/11/02.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

extension Reactive where Base: UIImageView {
        
    func image(placeholder: UIImage? = nil) -> Binder<Resource?> {
        return Binder(self.base) { imageView, resource in
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: resource, placeholder: placeholder)
        }
    }
}
