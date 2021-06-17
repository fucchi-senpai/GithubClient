//
//  BaseViewDelegate.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/17.
//

import Foundation

protocol BaseViewDelegate: AnyObject {
    /// initialize views
    func initViews()
    func initLoadingView()
    /// load API
    /// - Parameters:
    ///   - url: requestURLl
    ///   - completion: completion behavior
    func load(url: String, completion: @escaping (Data) -> Void)
    /// set up data from API
    /// - Parameter data: data from API
    func setUp(data: Data)
}
