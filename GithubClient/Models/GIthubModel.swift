//
//  GIthubModel.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/08.
//

import Foundation
import RxSwift

protocol GithubModel {
    var response: Observable<Data> { get }
    func fetchGithubUser(userName: String)
}

class GithubModelImpl: GithubModel {
    private let subject = PublishSubject<Data>()
    
    var response: Observable<Data> {
        return subject
    }
    /// Githubユーザー情報を取得する
    /// - Parameters:
    ///   - userName: body Githubニックネーム
    ///   - completion: HTTPS通信完了後処理
    func fetchGithubUser(userName: String) {
        // TODO: 検証用URL
        guard let url = URL(string: "https://api.github.com/users/\(userName)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let dataTask = URLSession.shared.dataTask(with: request) { [weak subject] (data, success, failure) in
            guard let data = data else { return }
            subject?.onNext(data)
            subject?.onCompleted()
//            completion(data)
        }
        dataTask.resume()
    }
}
