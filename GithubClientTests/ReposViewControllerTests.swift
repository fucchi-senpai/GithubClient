//
//  ReposViewControllerTests.swift
//  GithubClientTests
//
//  Created by Shota Fuchikami on 2021/06/13.
//

import XCTest
import RxSwift
@testable import GithubClient

class ReposViewControllerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testReposEqualityTest_fromGithubAPI_withSuccessfulResponse() {
        let githubModel = GithubModelTestRepos(mock: ReposVCTestMockData.success)
        let vc = RepoViewController(tableView: RepoTableView(), githubModel: githubModel, loadingview: LoadingView())
        vc.view.layoutIfNeeded()
        vc.delegate?.load(url: "") { data in
            vc.delegate?.setUp(data: data)
            let owner = Repos.User(loginName: ReposVCTestMockData.Const.loginName, avatarUrl: ReposVCTestMockData.Const.avatorUrl, bio: ReposVCTestMockData.Const.bio, url: ReposVCTestMockData.Const.url)
            let expect = Repos(name: ReposVCTestMockData.Const.reposName, htmlUrl: ReposVCTestMockData.Const.htmlUrl, description: ReposVCTestMockData.Const.description, stargazersCount: ReposVCTestMockData.Const.starCount, owner: owner)
            guard let actual = vc.reposDataList.first else {
                return
            }
            XCTAssertEqual(expect, actual)
        }
    }
    
    func testReposEqualityTest_fromGithubAPI_withAvatarUrlIsNil() {
        let githubModel = GithubModelTestRepos(mock: ReposVCTestMockData.avatarNil)
        let vc = RepoViewController(tableView: RepoTableView(), githubModel: githubModel, loadingview: LoadingView())
        vc.view.layoutIfNeeded()
        vc.delegate?.load(url: "") { data in
            vc.delegate?.setUp(data: data)
            let owner = Repos.User(loginName: ReposVCTestMockData.Const.loginName, avatarUrl: nil, bio: ReposVCTestMockData.Const.bio, url: ReposVCTestMockData.Const.url)
            let expect = Repos(name: ReposVCTestMockData.Const.reposName, htmlUrl: ReposVCTestMockData.Const.htmlUrl, description: ReposVCTestMockData.Const.description, stargazersCount: ReposVCTestMockData.Const.starCount, owner: owner)
            guard let actual = vc.reposDataList.first else {
                return
            }
            XCTAssertEqual(expect, actual)
        }
    }
    
    func testReposEqualityTest_fromGithubAPI_withOwnerNameIsNil() {
        let githubModel = GithubModelTestRepos(mock: ReposVCTestMockData.ownerNameNil)
        let vc = RepoViewController(tableView: RepoTableView(), githubModel: githubModel, loadingview: LoadingView())
        vc.view.layoutIfNeeded()
        vc.delegate?.load(url: "") { data in
            vc.delegate?.setUp(data: data)
            let owner = Repos.User(loginName: nil, avatarUrl: ReposVCTestMockData.Const.avatorUrl, bio: ReposVCTestMockData.Const.bio, url: ReposVCTestMockData.Const.url)
            let expect = Repos(name: ReposVCTestMockData.Const.reposName, htmlUrl: ReposVCTestMockData.Const.htmlUrl, description: ReposVCTestMockData.Const.description, stargazersCount: ReposVCTestMockData.Const.starCount, owner: owner)
            guard let actual = vc.reposDataList.first else {
                return
            }
            XCTAssertEqual(expect, actual)
        }
    }
    
    func testReposEqualityTest_fromGithubAPI_withReposNameIsNil() {
        let githubModel = GithubModelTestRepos(mock: ReposVCTestMockData.reposNameNil)
        let vc = RepoViewController(tableView: RepoTableView(), githubModel: githubModel, loadingview: LoadingView())
        vc.view.layoutIfNeeded()
        vc.delegate?.load(url: "") { data in
            vc.delegate?.setUp(data: data)
            let owner = Repos.User(loginName: ReposVCTestMockData.Const.loginName, avatarUrl: ReposVCTestMockData.Const.avatorUrl, bio: ReposVCTestMockData.Const.bio, url: ReposVCTestMockData.Const.url)
            let expect = Repos(name: nil, htmlUrl: ReposVCTestMockData.Const.htmlUrl, description: ReposVCTestMockData.Const.description, stargazersCount: ReposVCTestMockData.Const.starCount, owner: owner)
            guard let actual = vc.reposDataList.first else {
                return
            }
            XCTAssertEqual(expect, actual)
        }
    }
    
    func testReposEqualityTest_fromGithubAPI_withErrorResponse() {
        let githubModel = GithubModelTestRepos(mock: ReposVCTestMockData.error)
        let vc = RepoViewController(tableView: RepoTableView(), githubModel: githubModel, loadingview: LoadingView())
        vc.view.layoutIfNeeded()
        vc.delegate?.load(url: "") { data in
            vc.delegate?.setUp(data: data)
            XCTAssertNil(vc.reposDataList.first)
        }
    }
}


// MARK: Test Model

final class GithubModelTestRepos: GithubModel {
    
    private var mock: String
    
    init(mock: String) {
        self.mock = mock
    }
    
    func fetchGithub(requestUrl: String) -> Observable<Data> {
        return Observable.create({ observer in
            guard let data = self.mock.data(using: .utf8) else {
                return Disposables.create()
            }
            observer.on(.next(data))
            observer.on(.completed)
            return Disposables.create()
        })
    }
}

// MARK: Mock Data

struct ReposVCTestMockData {
    
    struct Const {
        static let reposName = "GithubClient"
        static let htmlUrl = "https://github.com/fucchi-senpai/GithubClient"
        static let description = "This is for test"
        static let starCount = 0
        static let loginName = "fucchi-senpai"
        static let avatorUrl = "https://avatars.githubusercontent.com/u/53225198?v=4"
        static let bio = "iOS Developer"
        static let url = "https://api.github.com/users/fucchi-senpai"
    }
    
    static let success = """
    [
        {
            "id": 111111,
            "name": "GithubClient",
            "full_name": "fucchi-senpai/GithubClient",
            "private": false,
            "owner": {
                "login": "fucchi-senpai",
                "id": 111111,
                "avatar_url": "https://avatars.githubusercontent.com/u/53225198?v=4",
                "url": "https://api.github.com/users/fucchi-senpai",
                "html_url": "https://github.com/fucchi-senpai",
                "type": "User",
                "site_admin": false,
                "bio": "iOS Developer"
            },
            "html_url": "https://github.com/fucchi-senpai/GithubClient",
            "description": "This is for test",
            "stargazers_count": 0,
        }
    ]
    """
    
    static let avatarNil = """
    [
        {
            "id": 111111,
            "name": "GithubClient",
            "full_name": "fucchi-senpai/GithubClient",
            "private": false,
            "owner": {
                "login": "fucchi-senpai",
                "id": 111111,
                "avatar_url": null,
                "url": "https://api.github.com/users/fucchi-senpai",
                "html_url": "https://github.com/fucchi-senpai",
                "type": "User",
                "site_admin": false,
                "bio": "iOS Developer"
            },
            "html_url": "https://github.com/fucchi-senpai/GithubClient",
            "description": "This is for test",
            "stargazers_count": 0,
        }
    ]
    """
    
    static let ownerNameNil = """
    [
        {
            "id": 111111,
            "name": "GithubClient",
            "full_name": "fucchi-senpai/GithubClient",
            "private": false,
            "owner": {
                "login": null,
                "id": 111111,
                "avatar_url": "https://avatars.githubusercontent.com/u/53225198?v=4",
                "url": "https://api.github.com/users/fucchi-senpai",
                "html_url": "https://github.com/fucchi-senpai",
                "type": "User",
                "site_admin": false,
                "bio": "iOS Developer"
            },
            "html_url": "https://github.com/fucchi-senpai/GithubClient",
            "description": "This is for test",
            "stargazers_count": 0,
        }
    ]
    """
    
    static let reposNameNil = """
    [
        {
            "id": 111111,
            "name": null,
            "full_name": "fucchi-senpai/GithubClient",
            "private": false,
            "owner": {
                "login": "fucchi-senpai",
                "id": 111111,
                "avatar_url": "https://avatars.githubusercontent.com/u/53225198?v=4",
                "url": "https://api.github.com/users/fucchi-senpai",
                "html_url": "https://github.com/fucchi-senpai",
                "type": "User",
                "site_admin": false,
                "bio": "iOS Developer"
            },
            "html_url": "https://github.com/fucchi-senpai/GithubClient",
            "description": "This is for test",
            "stargazers_count": 0,
        }
    ]
    """
    
    static let error = "[{}]"
}
