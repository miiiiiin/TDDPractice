////
////  AuthenticationService.swift
////  ClassCoordinatorExample
////
////  Created by Running Raccoon on 2022/02/15.
////
//
//
//import Action
//import Foundation
//import OAuthSwift
//import RxSwift
////import SwiftKeychainWrapper
//import UIKit
//
//protocol HasAuthenticationService {
//    var authService: AuthenticationServiceProtocol { get }
//}
//
//protocol AuthenticationServiceProtocol {
//    var handler: OAuth2Swift { get }
//    var client: AuthClientProtocol { get }
//    var renewAccessToken: CocoaAction { get }
//
//    func authenticate(useBuiltInSafari: Bool, viewController: UIViewController?) -> Observable<Bool>
//    func authenticateWitRefreshToken() -> Observable<Bool>
//    func logOut()
//}
//
//final class AuthenticationService: AuthenticationServiceProtocol {
//    typealias Dependencies = HasNoDependency
//
//    let handler: OAuth2Swift
//    let client: AuthClientProtocol
//
//    private let callbackUrl: URL
//    private let authorizationHeader: String
//    private let scope: String
//    private let bag = DisposeBag()
//    private let config: EnvironmentConfiguration
//    private let keychainWrapper: KeychainWrapper
//
//    // MARK: initializers
//
//    init(dependencies _: Dependencies) {
//        config = EnvironmentConfiguration.shared
//        keychainWrapper = KeychainWrapper(serviceName: config.keychain.serviceName, accessGroup: config.keychain.accessGroup)
//
//        callbackUrl = URL(string: config.auth.redirectUri)!
//        authorizationHeader = "Basic \(config.auth.clientHash)"
//        scope = config.auth.scope
//
//        handler = OAuth2Swift(consumerKey: config.auth.clientId,
//                              consumerSecret: config.auth.clientSecret,
//                              authorizeUrl: config.auth.authorizeUrl,
//                              accessTokenUrl: config.auth.tokenUrl,
//                              responseType: config.auth.responseType)
//        handler.allowMissingStateCheck = true
//        client = AuthClient(client: handler.client)
//    }
//
//    // MARK: public methods
//
//    /// Authenticate with CTU OAuth2.0 server
//    func authenticate(useBuiltInSafari: Bool = true, viewController: UIViewController? = nil) -> Observable<Bool> {
//        if CommandLine.arguments.contains("--stub-authentication") {
//            return Observable.just(true)
//        }
//
//        if useBuiltInSafari, let viewController = viewController {
//            handler.authorizeURLHandler = SafariURLHandler(viewController: viewController, oauthSwift: handler)
//        }
//
//        return Observable.create { [weak self] observer in
//            guard let self = self else {
//                observer.onCompleted()
//                return Disposables.create()
//            }
//
//            // Authorize
//            let handle = self.handler.authorize(withCallbackURL: self.callbackUrl,
//                                                scope: self.scope,
//                                                state: "",
//                                                headers: ["Authorization": self.authorizationHeader]) { [weak self] result in
//                switch result {
//                case .success:
//                    self?.saveCredentialsToKeychain()
//                    observer.onNext(true)
//                    observer.onCompleted()
//                case let .failure(error):
////                    Log.error("AuthenticationService.authenticate: Authentication error. \(error.localizedDescription)")
//                    #if DEBUG
//                        observer.onError(error)
//                    #endif
////                    observer.onError(AuthenticationError.generic)
//                }
//            }
//
//            return Disposables.create {
//                handle?.cancel()
//            }
//        }
//    }
//
//    /**
//     Authenticate with refresh token
//
//     Checks if refresh token is stored in the keychain. If yes, obtain a new access token with it.
//     - Returns Observable sequence that emits **true** if refresh token is stored and *false** if not
//     */
//    func authenticateWitRefreshToken() -> Observable<Bool> {
//        loadCredentialsFromKeychain()
//
//        if handler.client.credential.oauthRefreshToken.isEmpty {
//            return Observable.just(false)
//        }
//
////        return renewAccessToken.execute()
////            .catchError { [weak self] error in
////                if case let ActionError.underlyingError(underlyingError) = error,
////                   case AuthenticationError.invalidRefreshToken = underlyingError
////                {
//////                    Log.debug("Removed credentials")
////                    self?.removeCredentialsFromKeychain()
////                }
////                throw error
////            }
////            .map { _ in true }
//
//        return .just(true)
//    }
//
//    func logOut() {
//        removeCredentialsFromKeychain()
//    }
//
//    /// Renew access token with refresh token
//    lazy var renewAccessToken = CocoaAction { [weak self] in
//        Observable.create { [weak self] observer in
//            guard let self = self else { return Disposables.create() }
//            let credential = self.handler.client.credential
//
//            // Build request
//            var request = URLRequest(url: URL(string: self.config.auth.tokenUrl)!)
//            request.httpMethod = "POST"
//            request.setValue(self.authorizationHeader, forHTTPHeaderField: "Authorization")
//            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//            let body = "grant_type=refresh_token&refresh_token=\(credential.oauthRefreshToken)"
//            request.httpBody = body.data(using: .utf8)
//
//            // Make request
//            let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
//                if let error = error {
//                    Log.error("AuthenticationService:renewAccessToken: \(error)")
//                    observer.onError(error)
//                } else {
//                    if let data = data {
//                        do {
//                            let tokenResponse = try JSONDecoder().decode(AuthTokenResponse.self, from: data)
//
//                            // Set new tokens
//                            credential.oauthToken = tokenResponse.accessToken.safeStringByRemovingPercentEncoding
//                            credential.oauthRefreshToken = tokenResponse.refreshToken.safeStringByRemovingPercentEncoding
//                            credential.oauthTokenExpiresAt = Date(timeInterval: tokenResponse.expiresIn, since: Date())
//                            self?.saveCredentialsToKeychain()
//
//                            observer.onNext(())
//                            observer.onCompleted()
//                        } catch {
//                            if let errorDict: [String: String] = try? JSONDecoder().decode([String: String].self, from: data),
//                               let errorType = errorDict["error"]
//                            {
//                                if errorType == "invalid_grant" {
//                                    observer.onError(AuthenticationError.invalidRefreshToken)
//                                } else {
//                                    observer.onError(AuthenticationError.generic)
//                                }
//                            } else {
//                                let errorDescription = String(decoding: data, as: UTF8.self)
////                                Log.error("AuthenticationService: unprocessable data: \(errorDescription)")
//                                observer.onError(ApiError.unprocessableData)
//                            }
//                        }
//                    }
//                }
//            }
//            task.resume()
//
//            return Disposables.create {
//                task.cancel()
//            }
//        }
//    }
//
//    /// Save Auth credentials in keychain
//    private func saveCredentialsToKeychain() {
////        keychainWrapper.set(handler.client.credential.oauthRefreshToken,
////                            forKey: "refreshToken",
////                            withAccessibility: .afterFirstUnlock)
////        keychainWrapper.set(handler.client.credential.oauthToken,
////                            forKey: "accessToken",
////                            withAccessibility: .afterFirstUnlock)
////
////        guard let expiresAt = handler.client.credential.oauthTokenExpiresAt else { return }
////        keychainWrapper.set(expiresAt.toString(),
////                            forKey: "expiresAt",
////                            withAccessibility: .afterFirstUnlock)
//    }
//
//    private func loadCredentialsFromKeychain() {
//        if let refreshToken = keychainWrapper.string(forKey: "refreshToken") {
//            handler.client.credential.oauthRefreshToken = refreshToken
//        }
//    }
//
//    private func removeCredentialsFromKeychain() {
//        keychainWrapper.removeObject(forKey: "refreshToken")
//        keychainWrapper.removeObject(forKey: "accessToken")
//        keychainWrapper.removeObject(forKey: "expiresAt")
//    }
//}
