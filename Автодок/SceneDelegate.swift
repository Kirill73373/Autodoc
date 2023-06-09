//
//  SceneDelegate.swift
//  Автодок
//
//  Created by Кирилл Блохин on 16.03.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = UINavigationController(rootViewController: showNewsViewControler())
        window?.makeKeyAndVisible()
    }
    
    private func showNewsViewControler() -> UIViewController {
        let networkService = NetworkService()
        let viewModel = NewsViewModel(networkService: networkService)
        let viewController = NewsViewControler(viewModel: viewModel)
        return viewController
    }
}
