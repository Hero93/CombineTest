//
//  UIView+Animations.swift
//  CombineTest
//
//  Created by Luca Gramaglia on 10.05.21.
//

import UIKit
import Combine

extension UIView {
    class func animationPublisher(withDuration duration: TimeInterval, animations: @escaping () -> Void) -> Future<Bool, Never> {
        Future { promise in
            UIView.animate(withDuration: duration, animations: animations) {
                promise(.success($0))
            }
        }
    }
}
