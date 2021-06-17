//
//  MainTabBarViewController.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/07.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    private var githubModel: GithubModel?
    
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
        self.view.backgroundColor = .systemBackground
        self.initTabView()
    }
    
    private func initTabView() {
        print(#function)
        var viewcontrollers: [UIViewController] = []
        
        guard let githubModel = self.githubModel else { return }
        
        let firstViewController = RepoViewController(tableView: RepoTableView(), githubModel: githubModel, loadingview: LoadingView())
        firstViewController.tabBarItem = UITabBarItem(title: Const.NavigationTitle.repoPage, image: UIImage(systemName: "list.bullet"), selectedImage: UIImage(systemName: "list.bullet"))
        viewcontrollers.append(firstViewController)
        
        let secondViewController = ProfileViewController(githubModel: githubModel, loadingView: LoadingView())
        secondViewController.tabBarItem = UITabBarItem(title: Const.NavigationTitle.profilePage, image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person"))
        viewcontrollers.append(secondViewController)
        
        viewcontrollers = viewcontrollers.map({ UINavigationController(rootViewController: $0) })
        self.setViewControllers(viewcontrollers, animated: true)
    }

}
