//
//  UIImageExtension.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/08.
//

import Foundation
import UIKit

extension UIImage {
    
    /// URLから画像を読み込む
    /// - Parameter url: URL
    /// - Returns: URLから読み込んだ画像
    static func load(url: String) -> UIImage? {
        guard let url = URL(string: url) else {
            return nil
        }
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        return UIImage(data: data)
    }
}
