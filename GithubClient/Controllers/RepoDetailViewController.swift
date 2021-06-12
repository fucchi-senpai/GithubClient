//
//  RepoDetailViewController.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/06.
//

import UIKit

class RepoDetailViewController: UIViewController {
    
    private var navigationTitle: String?
    private var repoDetailView: RepoDetailView?
    
    init(repoDetailView: RepoDetailView, navigationTitle: String) {
        self.repoDetailView = repoDetailView
        self.navigationTitle = navigationTitle
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
        initNavigationView()
        initView()
    }
    
    private func initNavigationView() {
        self.navigationItem.title = self.navigationTitle
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    private func initView() {
        view.backgroundColor = .systemBackground
        guard let detailView = repoDetailView else { return }
        self.view.addSubview(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailView.heightAnchor.constraint(equalToConstant: 260),
            detailView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            detailView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            detailView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }

}
