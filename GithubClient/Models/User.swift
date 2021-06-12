//
//  User.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/08.
//

struct User: Decodable {
    var name: String
    var loginName: String
    var avatarUrl: String
    var bio: String?
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case loginName = "login"
        case avatarUrl = "avatar_url"
        case bio
        case url
    }
}
