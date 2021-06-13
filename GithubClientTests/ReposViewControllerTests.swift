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

    func testRepos() throws {
        XCTContext.runActivity(named: "success response", block: { _ in
            let vc = RepoViewController(tableView: RepoTableView(), githubModel: GithubModelTest())
            vc.view.layoutIfNeeded()
            vc.delegate?.load(url: "") { data in
                vc.delegate?.setUp(data: data)
                let owner = Repos.User(loginName: MockData.Sample.loginName, avatarUrl: MockData.Sample.avatorUrl, bio: MockData.Sample.bio, url: MockData.Sample.url)
                let expect = Repos(name: MockData.Sample.reposName, htmlUrl: MockData.Sample.htmlUrl, description: MockData.Sample.description, stargazersCount: MockData.Sample.starCount, owner: owner)
                guard let actual = vc.reposDataList.first else {
                    return
                }
                XCTAssertEqual(expect, actual)
            }
        })
        
        XCTContext.runActivity(named: "avatar url is nil", block: { _ in
            let vc = RepoViewController(tableView: RepoTableView(), githubModel: GithubModelTest2())
            vc.view.layoutIfNeeded()
            vc.delegate?.load(url: "") { data in
                vc.delegate?.setUp(data: data)
                let owner = Repos.User(loginName: MockData.Sample.loginName, avatarUrl: nil, bio: MockData.Sample.bio, url: MockData.Sample.url)
                let expect = Repos(name: MockData.Sample.reposName, htmlUrl: MockData.Sample.htmlUrl, description: MockData.Sample.description, stargazersCount: MockData.Sample.starCount, owner: owner)
                guard let actual = vc.reposDataList.first else {
                    return
                }
                XCTAssertEqual(expect, actual)
            }
        })
        
        XCTContext.runActivity(named: "owner name is nil", block: { _ in
            let vc = RepoViewController(tableView: RepoTableView(), githubModel: GithubModelTest3())
            vc.view.layoutIfNeeded()
            vc.delegate?.load(url: "") { data in
                vc.delegate?.setUp(data: data)
                let owner = Repos.User(loginName: nil, avatarUrl: MockData.Sample.avatorUrl, bio: MockData.Sample.bio, url: MockData.Sample.url)
                let expect = Repos(name: MockData.Sample.reposName, htmlUrl: MockData.Sample.htmlUrl, description: MockData.Sample.description, stargazersCount: MockData.Sample.starCount, owner: owner)
                guard let actual = vc.reposDataList.first else {
                    return
                }
                XCTAssertEqual(expect, actual)
            }
        })
        
        XCTContext.runActivity(named: "repositories name is nil", block: { _ in
            let vc = RepoViewController(tableView: RepoTableView(), githubModel: GithubModelTest4())
            vc.view.layoutIfNeeded()
            vc.delegate?.load(url: "") { data in
                vc.delegate?.setUp(data: data)
                let owner = Repos.User(loginName: MockData.Sample.loginName, avatarUrl: MockData.Sample.avatorUrl, bio: MockData.Sample.bio, url: MockData.Sample.url)
                let expect = Repos(name: nil, htmlUrl: MockData.Sample.htmlUrl, description: MockData.Sample.description, stargazersCount: MockData.Sample.starCount, owner: owner)
                guard let actual = vc.reposDataList.first else {
                    return
                }
                XCTAssertEqual(expect, actual)
            }
        })
        
        XCTContext.runActivity(named: "error response", block: { _ in
            // TODO: Not Implementation yet
        })
    }
}


// MARK: Test Model

final class GithubModelTest: GithubModel {
    func fetchGithub(requestUrl: String) -> Observable<Data> {
        return Observable.create({ observer in
            guard let data = MockData.success.data(using: .utf8) else {
                return Disposables.create()
            }
            observer.on(.next(data))
            observer.on(.completed)
            return Disposables.create()
        })
    }
}

final class GithubModelTest2: GithubModel {
    func fetchGithub(requestUrl: String) -> Observable<Data> {
        return Observable.create({ observer in
            guard let data = MockData.avatarNil.data(using: .utf8) else {
                return Disposables.create()
            }
            observer.on(.next(data))
            observer.on(.completed)
            return Disposables.create()
        })
    }
}

final class GithubModelTest3: GithubModel {
    func fetchGithub(requestUrl: String) -> Observable<Data> {
        return Observable.create({ observer in
            guard let data = MockData.ownerNameNil.data(using: .utf8) else {
                return Disposables.create()
            }
            observer.on(.next(data))
            observer.on(.completed)
            return Disposables.create()
        })
    }
}

final class GithubModelTest4: GithubModel {
    func fetchGithub(requestUrl: String) -> Observable<Data> {
        return Observable.create({ observer in
            guard let data = MockData.reposNameNil.data(using: .utf8) else {
                return Disposables.create()
            }
            observer.on(.next(data))
            observer.on(.completed)
            return Disposables.create()
        })
    }
}

// MARK: Mock Data

struct MockData {
    
    struct Sample {
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
    
}
