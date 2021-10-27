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
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        return view
    }()
    
    private(set) var didSetupConstraints = false
    
    // MARK: - Init -
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("activityIndicatorView stop")
        activityIndicatorView.stopAnimating()
    }
    
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        if !self.didSetupConstraints {
            self.didSetupConstraints = true
            self.setupConstraints()
        }
    }
    
    func setupConstraints() {
        activityIndicatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setUpUI() {
        self.view.setNeedsUpdateConstraints()
        self.view.addSubview(activityIndicatorView)
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        backItem.tintColor = .systemGray
        self.view.backgroundColor = .white
        self.navigationItem.backBarButtonItem = backItem
    }
}
