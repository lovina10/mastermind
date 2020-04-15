//
//  SceneDelegate.swift
//  Mastermind
//
//  Created by Lovina on 2/5/20.
//  Copyright © 2020 Lovina. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let tabBarController = UITabBarController()
            let mainVC = MainVC()
            let historyVC = HistoryVC()
            window.rootViewController = tabBarController
            tabBarController.addChild(mainVC)
            tabBarController.addChild(historyVC)
            let gameImage = UIImage.init(systemName: "gamecontroller", compatibleWith: .none)
            let historyImage = UIImage.init(systemName: "doc.text.magnifyingglass", compatibleWith: .none)
            mainVC.tabBarItem = UITabBarItem(title: "Game", image: gameImage, selectedImage: gameImage)
            historyVC.tabBarItem = UITabBarItem(title: "History", image: historyImage, selectedImage: historyImage)
            historyVC.game = mainVC.game
//            historyVC.game?.historyVCDelegate = historyVC
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
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

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

