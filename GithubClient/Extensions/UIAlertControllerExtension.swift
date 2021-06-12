//
//  UIAlertControllerExtension.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/12.
//

import UIKit

struct AlertContent {
    var title: String
    var message: String?
    var action: UIAlertAction
}

extension UIAlertController {
    /// AlertController 表示
    /// - Parameters:
    ///   - vc: ViewController
    ///   - content: title, message, action
    static func present(on vc: UIViewController, _ content: AlertContent) {
        let alertController = UIAlertController(title: content.title, message: content.message, preferredStyle: .alert)
        alertController.addAction(content.action)
        vc.present(alertController, animated: true, completion: nil)
    }
}
