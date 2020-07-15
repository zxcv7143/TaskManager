//
//  SceneDelegate.swift
//  Tareas
//
//  Created by Anton Zuev on 15/07/2020.
//

import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    if let windowScene = scene as? UIWindowScene {
      let window = UIWindow(windowScene: windowScene)
      window.rootViewController = UIHostingController(rootView: TaskListView())
      self.window = window
      window.makeKeyAndVisible()
    }
  }
}

