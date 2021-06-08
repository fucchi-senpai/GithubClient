//
//  MainTabBarViewController.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/07.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    deinit {
        print(#function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var viewcontrollers: [UIViewController] = []
        
        let firstViewController = RepoViewController(tableView: RepoTableView())
        firstViewController.tabBarItem = UITabBarItem(title: Const.NavigationTitle.repoPage, image: UIImage(systemName: "list.bullet"), selectedImage: UIImage(systemName: "list.bullet"))
        viewcontrollers.append(firstViewController)
        
        
        let userData = CellData(profileImageData: nil, ownerName: "fucchi-senpai", repositoryName: "GithubClient", aboutRepository: "iOS Developer", starCount: "2")
        let secondViewController = ProfileViewController(profileView: ProfileView(userData: userData))
        secondViewController.tabBarItem = UITabBarItem(title: Const.NavigationTitle.profilePage, image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person"))
        viewcontrollers.append(secondViewController)
        
        viewcontrollers = viewcontrollers.map({ UINavigationController(rootViewController: $0) })
        self.setViewControllers(viewcontrollers, animated: true)
    }

}
