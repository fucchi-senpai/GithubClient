//
//  RepoViewController.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/05.
//

import UIKit

class RepoViewController: UIViewController {
    
    private var tableView: RepoTableView?
    
    init(tableView: RepoTableView) {
        self.tableView = tableView
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
        initTableView()
    }
    
    private func initTableView() {
        guard let repoTableView = tableView else { return }
        self.view.addSubview(repoTableView)
        repoTableView.delegate = self
        repoTableView.translatesAutoresizingMaskIntoConstraints = false
        repoTableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        NSLayoutConstraint.activate([
            repoTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            repoTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            repoTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            repoTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

}

extension RepoViewController: RepoTableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = "test"
        return cell
    }
    
}
