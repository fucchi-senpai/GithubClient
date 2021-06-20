//
//  Settings.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/20.
//

import Foundation

struct Settings: Decodable {
    var githubClientId: String
    var githubClientSecrets: String
}
