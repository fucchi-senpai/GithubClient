//
//  GithubModel.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/08.
//

import Foundation
import RxSwift

protocol GithubModel {
    func fetchGithub(requestUrl: String) -> Observable<Data>
}

class GithubModelImpl: GithubModel {
    /// Githubユーザー情報を取得する
    /// - Parameter requestUrl: リクエストURL
    /// - Returns: JSONデータ
    func fetchGithub(requestUrl: String) -> Observable<Data> {
        return Observable.create({ observer in
            guard let url = URL(string: requestUrl) else { return Disposables.create() }
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
