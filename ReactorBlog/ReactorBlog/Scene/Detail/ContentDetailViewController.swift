//
//  ContentDetailViewController.swift
//  ReactorBlog
//
//  Created by Running Raccoon on 2021/11/03.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

final class ContentDetailViewController: BaseViewController, ReactorKit.View {

    typealias Reactor = ContentDetailReactor
    
    
    struct Font {
        static let nameLabel = UIFont.systemFont(ofSize: 15, weight: .black)
        static let titleLabel = UIFont.systemFont(ofSize: 20, weight: .semibold)
        static let contentsLabel = UIFont.systemFont(ofSize: 17, weight: .medium)
        static let dateLabel = UIFont.systemFont(ofSize: 15, weight: .medium)
    }
    
    // MARK: - UI -
    
    
    // MARK: - Init -
    
    init(reactor: Reactor) {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupConstraints() {
        
    }
    
    func bind(reactor: Reactor) {
        
    }
}
