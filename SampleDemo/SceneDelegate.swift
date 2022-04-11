//
//  SceneDelegate.swift
//  SampleDemo
//
//  Created by Srilatha Karancheti on 2022-04-11.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        if let navigationController = UIStoryboard(name: "Main", bundle: .main).instantiateInitialViewController() as? UINavigationController {
            window = UIWindow(frame: windowScene.coordinateSpace.bounds)
            window?.windowScene = windowScene
            window?.makeKeyAndVisible()
            window?.rootViewController = navigationController
            configureTopViewController(inNavigationController: navigationController)
        }
    }
    
    private func configureTopViewController(inNavigationController navController: UINavigationController) {
        if let propertListVC = navController.topViewController as? PropertyListViewController {
            propertListVC.service = PropertyListServiceProvider(networkSession: FakeNetworkSession.shared, select: { [weak propertListVC] property in
                propertListVC?.showDetails(property: property)
            }, addToFavourite: { [weak propertListVC] property in
                propertListVC?.addToFavorite(property: property)
            })
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

