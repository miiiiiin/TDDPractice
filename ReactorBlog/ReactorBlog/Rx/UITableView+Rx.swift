//
//  UITableView+Rx.swift
//  ReactorBlog
//
//  Created by Running Raccoon on 2021/10/27.
//

import RxSwift
import RxCocoa

extension Reactive where Base: UITableView {
    var deselectRow: Binder<IndexPath> {
        return Binder(self.base) { tableView, indexPath in
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
