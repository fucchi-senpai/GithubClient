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
        
        
        let secondViewController = UIViewController()
        secondViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person"))
        viewcontrollers.append(secondViewController)
        
        viewcontrollers = viewcontrollers.map({ UINavigationController(rootViewController: $0) })
        self.setViewControllers(viewcontrollers, animated: true)
    }

}
