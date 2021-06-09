//
//  GIthubModel.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/08.
//

import Foundation
import RxSwift

protocol GithubModel {
    func fetchGithubUser(userName: String) -> Observable<Data>
}

class GithubModelImpl: GithubModel {
    /// Githubユーザー情報を取得する
    /// - Parameters:
    ///   - userName: body Githubニックネーム
    /// - Returns: JSONデータ
    func fetchGithubUser(userName: String) -> Observable<Data> {
        return Observable.create({ observer in
            // TODO: 検証用URL
            guard let url = URL(string: "https://api.github.com/users/\(userName)") else { return Disposables.create() }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let dataTask = URLSession.shared.dataTask(with: request) { (data, success, error) in
                guard let response = data else {
                    observer.on(.error(error ?? RxError.unknown))
                    return
                }
                observer.on(.next(response))
                observer.on(.completed)
            }
            dataTask.resume()
            return Disposables.create()
        })
    }
}
