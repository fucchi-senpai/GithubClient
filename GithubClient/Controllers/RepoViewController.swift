//
//  RepoViewController.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/05.
//

import UIKit
import RxSwift

class RepoViewController: UIViewController {
    
    private var tableView: RepoTableView?
    private var githubModel: GithubModel?
    
    private var reposDataList: [Repos] = []
    private var subscription: Disposable? = nil
    
    init(tableView: RepoTableView, githubModel: GithubModel) {
        self.tableView = tableView
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
        self.loadRepositories {
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
        initTableView()
    }
    
    private func initNavigationView() {
        self.navigationItem.title = Const.NavigationTitle.repoPage
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    private func initTableView() {
        guard let repoTableView = tableView else { return }
        self.view.addSubview(repoTableView)
        repoTableView.delegate = self
        repoTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            repoTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            repoTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            repoTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            repoTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func loadRepositories(completion: @escaping () -> Void) {
        let result = self.githubModel?.fetchGithub(requestUrl: "https://api.github.com/users/fucchi-senpai/repos")
        self.subscription = result?.subscribe(onNext: { data in
            self.setUp(reposData: data)
            completion()
        })
    }
    
    private func setUp(reposData: Data) {
        do {
            let dataList = try JSONDecoder().decode([Repos].self, from: reposData)
            for data in dataList {
                self.reposDataList.append(data)
            }
            print("decode success: \(String(describing: self.reposDataList))")
        } catch let err {
            print("error: \(err)")
        }
    }

}

extension RepoViewController: RepoTableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reposDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let repos = self.reposDataList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Const.CellReuseIdentifier.repoCellView) ?? RepoTableViewCell(cellData: CellData(profileImageUrl: repos.owner.avatarUrl, ownerName: repos.owner.loginName, repositoryName: repos.name))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repos = self.reposDataList[indexPath.row]
        let userData = CellData(profileImageUrl: repos.owner.avatarUrl, ownerName: repos.owner.loginName, repositoryName: repos.name, aboutRepository: repos.description ?? "", starCount: String(repos.stargazersCount))
        let repoDetailView = RepoDetailView(userData: userData)
        self.navigationController?.pushViewController(RepoDetailViewController(repoDetailView: repoDetailView, navigationTitle: userData.repositoryName), animated: true)
    }
    
}
