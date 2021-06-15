//
//  Repos.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/10.
//

struct Repos: Decodable, Equatable {
    var name: String?
    var htmlUrl: String
    var description: String?
    var stargazersCount: Int
    var owner: User
    
    enum CodingKeys: String, CodingKey {
        case name
        case htmlUrl = "html_url"
        case description
        case stargazersCount = "stargazers_count"
        case owner
    }
    
    struct User: Decodable, Equatable {
        var loginName: String?
        var avatarUrl: String?
        var bio: String?
        var url: String
        
        enum CodingKeys: String, CodingKey {
            case loginName = "login"
            case avatarUrl = "avatar_url"
            case bio
            case url
        }
    }
}
