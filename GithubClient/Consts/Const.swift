//
//  Const.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/06.
//

struct Const {
    struct CellReuseIdentifier {
        static let repoCellView = "repoCellView"
    }
    
    struct NavigationTitle {
        static let repoPage = "Repositories"
        static let profilePage = "Profile"
    }
    
    struct AssetsName {
        static let githubMark = "GitHubMark"
    }
    
    struct AlertContent {
        static let title = "エラー"
        static let message = "しばらく経ってから再度お試しください。"
        static let buttonLabel = "OK"
    }
    
    struct Optional {
        static let noOwnerName = "No owner name"
        static let noReposName = "No repos name"
        static let blank = ""
    }
    
    struct DataStoreKey {
        static let accessToken = "ACCESS_TOKEN"
    }
}
