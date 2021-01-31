//
//  AppAlert.swift
//  RestaurantApp
//
//  Created by Tristan Newman on 1/31/21.
//

import UIKit

final class AppAlert: NSObject {
    static let shared = AppAlert()

    func showBasic(title: String?,
                   message: String?,
                   viewController: UIViewController,
                   handler: ((UIAlertAction) -> Void)? = nil,
                   actionTItle: String = "OK") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTItle, style: .default, handler: handler))
        viewController.present(alert, animated: true)
    }
}
