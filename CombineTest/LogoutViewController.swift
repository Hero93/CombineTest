//
//  SyncViewController.swift
//  CombineTest
//
//  Created by Luca Gramaglia on 10.05.21.
//

import UIKit
import Combine

class LogoutViewController: UIViewController {

    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.addTarget(self, action: #selector(logoutButtonAction), for: .touchUpInside)
        return button
    }()

    // MARK: - Properties

    private let viewModel: LogoutViewModel = LogoutViewModel()

    private var logoutSubject = PassthroughSubject<Void, ServiceError>()
    lazy var onLogout = logoutSubject.eraseToAnyPublisher()
    private var subscriptions = Set<AnyCancellable>()

    // What I would like to use (pass the Future around)
//    var onLogout: Future<Void, ServiceError>?

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    // MARK: - UI Interaction(s)

    @objc private func logoutButtonAction() {
        showLogoutAlert {
            self.viewModel.logout()
                .sink(receiveCompletion: { completion in
                    self.logoutSubject.send(completion: completion)
                }, receiveValue: { _ in })
                .store(in: &self.subscriptions)
        }
    }
}

// MARK: - View Setup

extension LogoutViewController {

    private func setupViews() {
        view.backgroundColor = .yellow

        view.addSubview(logoutButton)
        logoutButton.constrainCenterInSuperview()
    }
}

// MARK: - Utils

extension LogoutViewController {
    private func showLogoutAlert(completion: @escaping () -> Void) {
        let alert = UIAlertController.init(title: "Test", message: "Are you sure you want to logout?", preferredStyle: .alert)
        let positiveAction = UIAlertAction(title: "Yes", style: .default) { _ in
            completion()
        }
        let negativeAction = UIAlertAction(title: "No", style: .cancel)
        alert.addAction(positiveAction)
        alert.addAction(negativeAction)
        present(alert, animated: true)
    }
}
