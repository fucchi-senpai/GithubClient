//
//  BaseViewDelegate.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/12.
//

import Foundation

protocol BaseViewDelegate: AnyObject {
    func load(url: String, completion: @escaping (Data) -> Void)
    func setUp(data: Data)
}
