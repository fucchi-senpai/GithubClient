//
//  ProfileViewController.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/07.
//

import UIKit
import RxSwift

class ProfileViewController: UIViewController {
    
    private weak var delegate: BaseViewDelegate?
    private var githubModel: GithubModel?
    
    private var subscription: Disposable? = nil
    private var userData: UserEntity? = nil
    
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
        self.delegate = self
        self.delegate?.load(url: "https://api.github.com/users/fucchi-senpai") { data in
            self.setUp(data: data)
            DispatchQueue.main.async {
                self.initView()
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.subscription?.dispose()
    }
    
    private func initView() {
        view.backgroundColor = .systemBackground
        initNavigationView()
        initProfileView()
    }
    
    private func initNavigationView() {
        self.navigationItem.title = Const.NavigationTitle.profilePage
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    private func initProfileView() {
        guard let userData = self.userData else { return }
        let profileView = ProfileView(userData: userData)
        self.view.addSubview(profileView)
        profileView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4),
            profileView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            profileView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16.0),
            profileView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
}

extension ProfileViewController: BaseViewDelegate {
    
    func load(url: String, completion: @escaping (Data) -> Void) {
        let result = self.githubModel?.fetchGithub(requestUrl: url)
        self.subscription = result?.subscribe(onNext: { data in
            completion(data)
        })
    }
    
    func setUp(data: Data) {
        do {
            let user = try JSONDecoder().decode(User.self, from: data)
            self.userData = UserEntity(profileImageUrl: user.avatarUrl, name: user.name, bio: user.bio)
            print("decode success: \(String(describing: self.userData))")
        } catch let err {
            print("error: \(err)")
        }
    }
    
}
