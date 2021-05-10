//
//  NavigationRouter.swift
//  CombineTest
//
//  Created by Luca Gramaglia on 10.05.21.
//

import UIKit

public protocol NavigationRouterOutput: AnyObject {
    var onWillShowViewController: ((UIViewController) -> Void)? { get set }
    var onDidShowViewController: ((UIViewController) -> Void)? { get set }
}

public final class NavigationRouter: NSObject, NavigationRouterOutput {
    private let navigationController = UINavigationController()

    public var navigationStack: [UIViewController] {
        return navigationController.viewControllers
    }

    public var onWillShowViewController: ((UIViewController) -> Void)?
    public var onDidShowViewController: ((UIViewController) -> Void)?
}

// MARK: -

extension NavigationRouter: Presentable {
    public func toPresent() -> UIViewController {
        return navigationController
    }
}

public protocol Presentable {
    func toPresent() -> UIViewController
}

extension UIViewController: Presentable {
    public func toPresent() -> UIViewController {
        return self
    }
}

// MARK: -

extension NavigationRouter {
    public func setRoot(_ viewController: UIViewController, animated: Bool) {
        setNavigationStack([viewController], animated: animated)
    }

    public func setNavigationStack(_ navigationStack: [UIViewController], animated: Bool) {
        navigationController.setViewControllers(navigationStack, animated: animated)
    }

    public func push(_ viewController: UIViewController, animated: Bool) {
        navigationController.pushViewController(viewController, animated: animated)
    }

    public func pop(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }

    public func pop(to viewController: UIViewController, animated: Bool) {
        navigationController.popToViewController(viewController, animated: animated)
    }

    public func popToRoot(animated: Bool) {
        navigationController.popToRootViewController(animated: animated)
    }

    // MARK: -

    public func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        navigationController.present(viewController, animated: animated, completion: completion)
    }

    public func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
        navigationController.dismiss(animated: animated, completion: completion)
    }
}
