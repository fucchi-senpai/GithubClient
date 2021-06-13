//
//  LoadingView.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/13.
//

import UIKit

class LoadingView: UIView {
    
    private let loadingView = UIActivityIndicatorView(frame: .zero)

    deinit {
        print(#function)
    }
    
    override func layoutSubviews() {
        refresh()
    }
    
    func refresh() {
        initLoadingView()
    }
    
    func start() {
        loadingView.startAnimating()
    }
    
    func stop() {
        loadingView.stopAnimating()
    }
    
    private func initLoadingView() {
        addSubview(loadingView)
        loadingView.style = .large
        loadingView.color = .systemGray
        loadingView.hidesWhenStopped = true
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.heightAnchor.constraint(equalTo: heightAnchor),
            loadingView.widthAnchor.constraint(equalTo: widthAnchor),
            loadingView.centerYAnchor.constraint(equalTo: centerYAnchor),
            loadingView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
