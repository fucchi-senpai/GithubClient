//
//  GIthubModel.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/08.
//

import Foundation

protocol GithubModel {
    func fetchGithubUser(userName: String, completion: @escaping (Data) -> Void)
}

class GithubModelImpl: GithubModel {
    /// Githubユーザー情報を取得する
    /// - Parameters:
    ///   - userName: body Githubニックネーム
    ///   - completion: HTTPS通信完了後処理
    func fetchGithubUser(userName: String, completion: @escaping (Data) -> Void) {
        // TODO: 検証用URL
        guard let url = URL(string: "https://api.github.com/users/\(userName)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let dataTask = URLSession.shared.dataTask(with: request) { (data, success, failure) in
            guard let data = data else { return }
            completion(data)
        }
        dataTask.resume()
    }
}
