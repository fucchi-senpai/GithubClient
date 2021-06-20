//
//  SceneDelegate.swift
//  GithubClient
//
//  Created by Shota Fuchikami on 2021/06/05.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        loadSettings() { url in
            DispatchQueue.main.async {
                guard let windowScene = (scene as? UIWindowScene) else { return }
                let window = UIWindow(windowScene: windowScene)
                window.rootViewController = UINavigationController(rootViewController: WebViewController(url: url))
                self.window = window
                window.makeKeyAndVisible()
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    private func loadSettings(completion: @escaping (String) -> Void) {
        do {
            let settingURL: URL = URL(fileURLWithPath: Bundle.main.path(forResource: "settings", ofType: "plist")!)
            let data = try Data(contentsOf: settingURL)
            let decoder = PropertyListDecoder()
            let settings = try decoder.decode(Settings.self, from: data)
            print("settings.githubClientId: \(settings.githubClientId)")
            completion("https://github.com/login/oauth/authorize?client_id=\(settings.githubClientId)&scope=public_repo")
        } catch let error {
            print("error: \(error)")
        }
    }

}

