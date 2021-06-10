//
//  RepoViewController.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/05.
//

import UIKit

class RepoViewController: UIViewController {
    
    private var tableView: RepoTableView?
    private var reposDataList: [Repos]
    
    init(tableView: RepoTableView, reposDataList: [Repos]) {
        self.tableView = tableView
        self.reposDataList = reposDataList
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
        self.initView()
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

}

extension RepoViewController: RepoTableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reposDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let repos = self.reposDataList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Const.CellReuseIdentifier.repoCellView) ?? RepoTableViewCell(cellData: CellData(profileImageData: repos.owner.avatarUrl, ownerName: repos.owner.loginName, repositoryName: repos.name))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repos = self.reposDataList[indexPath.row]
        let userData = CellData(profileImageData: repos.owner.avatarUrl, ownerName: repos.owner.loginName, repositoryName: repos.name, aboutRepository: repos.description ?? "", starCount: String(repos.stargazersCount))
        let repoDetailView = RepoDetailView(userData: userData)
        self.navigationController?.pushViewController(RepoDetailViewController(repoDetailView: repoDetailView, navigationTitle: userData.repositoryName), animated: true)
    }
    
}
