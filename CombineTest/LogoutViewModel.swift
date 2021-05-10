//
//  LogoutViewModel.swift
//  CombineTest
//
//  Created by Luca Gramaglia on 10.05.21.
//

import UIKit
import Combine

class LogoutViewModel: NSObject {

    func logout() -> Future<Void, ServiceError> {
        return Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                promise(.success(()))
            }
        }
    }
}
