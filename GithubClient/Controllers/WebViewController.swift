//
//  WebViewController.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/20.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
    private var webView: WKWebView?
    private var url: String?
    private var settings: Settings?
    
    init(url: String, settings: Settings? = nil) {
        self.url = url
        self.settings = settings
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
        initWebView()
        let myURL = URL(string: self.url ?? "")
        let myRequest = URLRequest(url: myURL!)
        webView?.load(myRequest)
    }
    
    private func initWebView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        guard let webView = self.webView else { return }
        self.view.addSubview(webView)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            webView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            webView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }
    
    private func fallbackOAuth(with url: URL) {
        guard let urlComponent = URLComponents(string: url.absoluteString) else {
            return
        }
        let code = urlComponent.queryItems?.first(where: {
            $0.name == "code"
        })?.value
        let requestParams = [
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "client_id", value: settings?.githubClientId),
            URLQueryItem(name: "client_secret", value: settings?.githubClientSecrets)
        ]
        let obserber = GithubApiManager.getAccessToken(requestParam: requestParams)
        obserber.subscribe(onNext: { data in
            do {
                let json = try JSONDecoder().decode([String: String].self, from: data)
                let accessToken = json["access_token"]
                DataStore.saveString(accessToken, forKey: Const.DataStoreKey.accessToken)
                DispatchQueue.main.async {
                    let vc = MainTabBarViewController(githubModel: GithubModelImpl())
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
            } catch let error {
                print("error: \(error)")
            }
        })
    }

}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else {
            return
        }
        if url.scheme == "githubclient" && url.host == "oauth" {
            self.dismiss(animated: true, completion: nil)
            fallbackOAuth(with: url)
        }
        decisionHandler(WKNavigationActionPolicy.allow)
    }
}
