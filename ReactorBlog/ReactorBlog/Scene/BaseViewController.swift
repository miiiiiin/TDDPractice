//
//  BaseViewController.swift
//  ReactorBlog
//
//  Created by Running Raccoon on 2021/10/26.
//

import Foundation
import UIKit
import RxSwift
import SnapKit

class BaseViewController: UIViewController {
    
    // MARK: - Init -
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.setNeedsUpdateConstraints()
        
        setUpUI()
        
    }
    
    private func setUpUI() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        backItem.tintColor = .systemGray
        self.view.backgroundColor = .white
        self.navigationItem.backBarButtonItem = backItem
    }
}
