//
//  MainTabBarViewController.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/07.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    private var githubModel: GithubModel?
    private var userData: User? = nil
    
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
        DispatchQueue.global().async {
            self.loadUser()
        }
        DispatchQueue.main.async {
            self.initTabView()
        }
    }
    
    private func initTabView() {
        print(#function)
        var viewcontrollers: [UIViewController] = []
        
        let firstViewController = RepoViewController(tableView: RepoTableView())
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
    
    private func loadUser() {
        self.githubModel?.fetchGithubUser(userName: "fucchi-senpai") { data in
            do {
                self.userData = try JSONDecoder().decode(User.self, from: data)
                print("decode success: \(String(describing: self.userData))")
            } catch let err {
                print("error: \(err)")
            }
        }
    }

}
