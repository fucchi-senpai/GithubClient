//
//  ProfileViewControllerTests.swift
//  GithubClientTests
//
//  Created by Shota Fuchikami on 2021/06/14.
//

import XCTest
import RxSwift
@testable import GithubClient

class ProfileViewControllerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testProfileEqualityTest_fromGithubAPI_withSuccessfulResponse() {
        let githubModel = GithubModelTestProfile(mock: ProfileVCTestMockData.success)
        let vc = ProfileViewController(githubModel: githubModel)
        vc.view.layoutIfNeeded()
        vc.delegate?.load(url: "") { data in
            vc.delegate?.setUp(data: data)
            let expect = UserEntity(profileImageUrl: ProfileVCTestMockData.Const.avatorUrl, name: ProfileVCTestMockData.Const.name, bio: ProfileVCTestMockData.Const.bio)
            guard let actual = vc.userData else {
                return
            }
            XCTAssertEqual(expect, actual)
        }
    }
    
    func testProfileEqualityTest_fromGithubAPI_withAvatarUrlIsNil() {
        let githubModel = GithubModelTestProfile(mock: ProfileVCTestMockData.avatarNil)
        let vc = ProfileViewController(githubModel: githubModel)
        vc.view.layoutIfNeeded()
        vc.delegate?.load(url: "") { data in
            vc.delegate?.setUp(data: data)
            let expect = UserEntity(profileImageUrl: nil, name: ProfileVCTestMockData.Const.name, bio: ProfileVCTestMockData.Const.bio)
            guard let actual = vc.userData else {
                return
            }
            XCTAssertEqual(expect, actual)
        }
    }
    
    func testProfileEqualityTest_fromGithubAPI_withNameIsNil() {
        let githubModel = GithubModelTestProfile(mock: ProfileVCTestMockData.nameNil)
        let vc = ProfileViewController(githubModel: githubModel)
        vc.view.layoutIfNeeded()
        vc.delegate?.load(url: "") { data in
            vc.delegate?.setUp(data: data)
            let expect = UserEntity(profileImageUrl: ProfileVCTestMockData.Const.avatorUrl, name: nil, bio: ProfileVCTestMockData.Const.bio)
            guard let actual = vc.userData else {
                return
            }
            XCTAssertEqual(expect, actual)
        }
    }
    
    func testProfileEqualityTest_fromGithubAPI_withBioIsNil() {
        let githubModel = GithubModelTestProfile(mock: ProfileVCTestMockData.bioNil)
        let vc = ProfileViewController(githubModel: githubModel)
        vc.view.layoutIfNeeded()
        vc.delegate?.load(url: "") { data in
            vc.delegate?.setUp(data: data)
            let expect = UserEntity(profileImageUrl: ProfileVCTestMockData.Const.avatorUrl, name: ProfileVCTestMockData.Const.name, bio: nil)
            guard let actual = vc.userData else {
                return
            }
            XCTAssertEqual(expect, actual)
        }
    }
    
    func testProfileEqualityTest_fromGithubAPI_withErrorResponse() {
        let githubModel = GithubModelTestProfile(mock: ProfileVCTestMockData.error)
        let vc = ProfileViewController(githubModel: githubModel)
        vc.view.layoutIfNeeded()
        vc.delegate?.load(url: "") { data in
            vc.delegate?.setUp(data: data)
            XCTAssertNil(vc.userData)
        }
    }

}

// MARK: Test Model

final class GithubModelTestProfile: GithubModel {
    
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

struct ProfileVCTestMockData {
    
    struct Const {
        static let loginName = "fucchi-senpai"
        static let name = "Shota Fuchikami"
        static let avatorUrl = "https://avatars.githubusercontent.com/u/53225198?v=4"
        static let bio = "iOS Developer"
        static let url = "https://api.github.com/users/fucchi-senpai"
    }
    
    static let success = """
    {
        "login": "fucchi-senpai",
        "id": 111111,
        "name": "Shota Fuchikami",
        "avatar_url": "https://avatars.githubusercontent.com/u/53225198?v=4",
        "url": "https://api.github.com/users/fucchi-senpai",
        "html_url": "https://github.com/fucchi-senpai",
        "type": "User",
        "bio": "iOS Developer"
    }
    """
    
    static let avatarNil = """
    {
        "login": "fucchi-senpai",
        "id": 111111,
        "name": "Shota Fuchikami",
        "avatar_url": null,
        "url": "https://api.github.com/users/fucchi-senpai",
        "html_url": "https://github.com/fucchi-senpai",
        "type": "User",
        "bio": "iOS Developer"
    }
    """
    
    static let nameNil = """
    {
        "login": "fucchi-senpai",
        "id": 111111,
        "name": null,
        "avatar_url": "https://avatars.githubusercontent.com/u/53225198?v=4",
        "url": "https://api.github.com/users/fucchi-senpai",
        "html_url": "https://github.com/fucchi-senpai",
        "type": "User",
        "bio": "iOS Developer"
    }
    """
    
    static let bioNil = """
    {
        "login": "fucchi-senpai",
        "id": 111111,
        "name": "Shota Fuchikami",
        "avatar_url": "https://avatars.githubusercontent.com/u/53225198?v=4",
        "url": "https://api.github.com/users/fucchi-senpai",
        "html_url": "https://github.com/fucchi-senpai",
        "type": "User",
        "bio": null
    }
    """
    
    static let error = "{}"
}
