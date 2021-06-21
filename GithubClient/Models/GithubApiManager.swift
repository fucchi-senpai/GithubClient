//
//  GithubApiManager.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/20.
//

import Foundation
import RxSwift

struct GithubApiManager {
    
    static func getAccessToken(requestParam: [URLQueryItem]) -> Observable<Data> {
        return Observable.create({ observer in
            print("requestParameter: \(requestParam)")
            let requestHeader = ["Accept": "application/json"]
            guard var urlComponents = URLComponents(string: "https://github.com/login/oauth/access_token") else {
                return Disposables.create()
            }
            urlComponents.queryItems = requestParam
            guard let url = urlComponents.url else { return Disposables.create() }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = requestHeader
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
