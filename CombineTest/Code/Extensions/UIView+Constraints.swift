//
//  UIView+Constraints.swift
//  CombineTest
//
//  Created by Luca Gramaglia on 10.05.21.
//

import UIKit

public extension UIView {
    /// Activate constraints of the given view. No need to set `translatesAutoresizingMaskIntoConstraints = false`.
    /// - parameter configuration: A closure that takes the view for constraint configuration.
    func activateConstraints(configuration: (_ view: UIView) -> [NSLayoutConstraint]) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(configuration(self))
    }

    /// Centers the view inside it's superview
    func constrainCenterInSuperview() {
        guard let superview = superview else {
            assertionFailure("View must have a superview!")
            return
        }
        constrainCenter(in: superview)
    }

    /// Centers the view inside the target
    /// - parameter view: target view to center into
    func constrainCenter(in view: UIView) {
        activateConstraints {[
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            $0.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]}
    }

    /// Constrains the heightAnchor to the given height.
    /// - parameter height: height of the view
    func constrainHeight(to height: CGFloat) {
        activateConstraints {[
            $0.heightAnchor.constraint(equalToConstant: height)
        ]}
    }

    /// Constrains the widthAnchor to the given width.
    /// - parameter height: width of the view
    func constrainWidth(to width: CGFloat) {
        activateConstraints {[
            $0.widthAnchor.constraint(equalToConstant: width)
        ]}
    }

    /// Constrains the widthAnchor and heightAnchor to the given size.
    /// - parameter size: size of the view
    func constrainSize(to size: CGSize) {
        activateConstraints {[
            $0.widthAnchor.constraint(equalToConstant: size.width),
            $0.heightAnchor.constraint(equalToConstant: size.height)
        ]}
    }
}
