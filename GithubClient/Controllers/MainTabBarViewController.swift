//
//  MainTabBarViewController.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/07.
//

import UIKit
import RxSwift

class MainTabBarViewController: UITabBarController {
    
    private var githubModel: GithubModel?
    private var subscription: Disposable?
    private var userData: User? = nil
    private var reposList: [Repos] = []
    private let requestUrl = "https://api.github.com/users/fucchi-senpai"
    
    init(githubModel: GithubModel) {
        self.githubModel = githubModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print(#function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: 見直し
        self.loadGithub {
            DispatchQueue.main.async {
                self.initTabView()
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.subscription?.dispose()
    }
    
    private func initTabView() {
        print(#function)
        var viewcontrollers: [UIViewController] = []
        
        let firstViewController = RepoViewController(tableView: RepoTableView(), reposDataList: self.reposList)
        firstViewController.tabBarItem = UITabBarItem(title: Const.NavigationTitle.repoPage, image: UIImage(systemName: "list.bullet"), selectedImage: UIImage(systemName: "list.bullet"))
        viewcontrollers.append(firstViewController)
        
        guard let user = self.userData else { return }
        let userData = UserEntity(profileImageUrl: user.avatarUrl, name: user.name, bio: user.bio)
        let secondViewController = ProfileViewController(profileView: ProfileView(userData: userData))
        secondViewController.tabBarItem = UITabBarItem(title: Const.NavigationTitle.profilePage, image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person"))
        viewcontrollers.append(secondViewController)
        
        viewcontrollers = viewcontrollers.map({ UINavigationController(rootViewController: $0) })
        self.setViewControllers(viewcontrollers, animated: true)
    }
    
    private func loadGithub(completion: @escaping () -> Void) {
        let resultUser = self.githubModel?.fetchGithub(requestUrl: requestUrl)
        let resultRepos = self.githubModel?.fetchGithub(requestUrl: "\(requestUrl)/repos")
        
        self.subscription = Observable.combineLatest(resultUser!, resultRepos!).subscribe(onNext: { userData, repos in
            print("onNext")
            self.setUp(userData: userData)
            self.setUp(reposData: repos)
            completion()
        }, onDisposed: {
            print("onDisposed")
        })
    }
    
    private func setUp(userData: Data) {
        do {
            self.userData = try JSONDecoder().decode(User.self, from: userData)
            print("decode success: \(String(describing: self.userData))")
        } catch let err {
            print("error: \(err)")
        }
    }
    
    private func setUp(reposData: Data) {
        do {
            let dataList = try JSONDecoder().decode([Repos].self, from: reposData)
            for data in dataList {
                self.reposList.append(data)
            }
            print("decode success: \(String(describing: self.userData))")
        } catch let err {
            print("error: \(err)")
        }
    }

}
