//
//  SceneDelegate.swift
//  CombineTest
//
//  Created by Luca Gramaglia on 10.05.21.
//

import UIKit
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    private var subscriptions = Set<AnyCancellable>()
    private let logoutCoordinator = LogoutCoordinator()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)

        logoutCoordinator.onLogout
            .sink(receiveCompletion: { completion in
                print("Open another view!!!")
            }, receiveValue: { _ in })
            .store(in: &subscriptions)

        window.rootViewController = logoutCoordinator.rootController
        self.window = window
        window.makeKeyAndVisible()
    }
}
