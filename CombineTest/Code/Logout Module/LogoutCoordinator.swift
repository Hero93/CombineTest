//
//  LogoutCoordinator.swift
//  CombineTest
//
//  Created by Luca Gramaglia on 10.05.21.
//

import UIKit
import Combine

enum ServiceError: Error {
    case noWifi
}

class LogoutCoordinator: Coordinator {

    private final let router = NavigationRouter()
    public override var rootController: UIViewController {
        return router.toPresent()
    }

    private var logoutSubject = PassthroughSubject<Void, ServiceError>()
    lazy var onLogout = logoutSubject.eraseToAnyPublisher()

    var subscriptions = Set<AnyCancellable>()

    // What I would like to use (pass the Future around)
//    var onLogout: Future<Void, ServiceError>?

    // MARK: - Init

    override init() {
        super.init()

        let syncViewController = LogoutViewController()
        // What I would like to use (pass the Future around)
//        syncViewController.onLogout = onLogout
        syncViewController.onLogout
            .sink(receiveCompletion: { [weak self] completion in
                self?.logoutSubject.send(completion: completion)
            }, receiveValue: { _ in })
            .store(in: &subscriptions)
        router.setRoot(syncViewController, animated: true)
    }
}
