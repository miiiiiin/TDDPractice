//
//  LoginViewController.swift
//  ClassCoordinatorExample
//
//  Created by Running Raccoon on 2022/02/15.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class LoginViewController: BaseViewController, BindableType {
    
    
    // MARK: UI elements

    var loginButton: UIButton!
    var privacyButton: UIButton!

    // MARK: properties

    var viewModel: LoginViewModel!
    private let disposeBag = DisposeBag()

    // MARK: lifecycle methods

    override func loadView() {
        super.loadView()
        
        // Logo
        let logo = UIImage(named: "FullTextLogo")
        let logoView = UIImageView(image: logo)
        view.addSubview(logoView)
        logoView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(view.frame.height * 0.25) // Relative inset
        }

        // Login button
        let button = UIPrimaryButton()
        button.accessibilityIdentifier = "Login"
        button.setTitle("로그인", for: .normal)
        button.addTarget(self, action: #selector(authButtonTapped(_:)), for: .primaryActionTriggered)
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.width.equalTo(180)
            make.height.equalTo(60)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(view.frame.height * 0.2)
        }
        loginButton = button

        let privacyButton = UIButton()
        privacyButton.setTitle("프라이버시", for: .normal)
        privacyButton.setTitleColor(UIColor.Theme.secondary, for: .normal)
//        privacyButton.titleLabel?.font = UIFont.Grades.body
        privacyButton.titleLabel?.textAlignment = .center
        view.addSubview(privacyButton)
        privacyButton.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        self.privacyButton = privacyButton
        
        
    }
    
    // MARK: methods

    override func viewDidLoad() {
        super.viewDidLoad()
//        viewModel.fetchRemoteConfig()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func bindViewModel() {
        guard let viewModel = viewModel else { return }

//        viewModel.authenticateWithRefresToken()
//            .subscribeOn(MainScheduler.instance)
//            .subscribe(onError: { [weak self] error in
//                Log.report(error)
//
//                DispatchQueue.main.async {
//                    if let view = self?.view {
//                        if case let ActionError.underlyingError(underlyingError) = error {
//                            view.makeCustomToast(underlyingError.localizedDescription, type: .danger)
//                        } else {
//                            view.makeCustomToast(error.localizedDescription, type: .danger)
//                        }
//                    }
//                }
//            })
//            .disposed(by: bag)
        
        let fetching = viewModel.fetching.distinctUntilChanged().share()
        fetching.asDriver(onErrorJustReturn: false).drive(view.rx.refreshing).disposed(by: disposeBag)
        fetching.map { !$0 }.asDriver(onErrorJustReturn: false).drive(loginButton.rx.isEnabled).disposed(by: disposeBag)
        
        
        
    }
    
    // MARK: events

    @objc private func authButtonTapped(_: UIButton) {
//        viewModel.authenticate(viewController: self)
//            .subscribeOn(MainScheduler.instance)
//            .subscribe(onError: { [weak self] error in
//                DispatchQueue.main.async {
//                    if let view = self?.view {
//                        view.makeCustomToast(error.localizedDescription, type: .danger)
//                    }
//                }
//            })
//            .disposed(by: bag)
    }
    
}
