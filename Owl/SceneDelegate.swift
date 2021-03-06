//
//  SceneDelegate.swift
//  Owl
//
//  Created by Dennis Vera on 10/30/20.
//  Copyright © 2020 Dennis Vera. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  // MARK: - Properties

  var window: UIWindow?

  // MARK: -

  private let appCoordinator = AppCoordinator()
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    // Initialize Window
    guard let windowScene = scene as? UIWindowScene else { return }
    window = UIWindow(windowScene: windowScene)

    // Configure Window
    window?.rootViewController = appCoordinator.rootViewController

    // Make Key and Visible
    window?.makeKeyAndVisible()

    // Start Coordinator
    appCoordinator.start()
  }
}
