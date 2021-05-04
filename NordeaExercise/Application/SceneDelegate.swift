//
//  SceneDelegate.swift
//  NordeaExercise
//
//  Created by Laitarenko Roman on 30.4.2021.
//

import UIKit
import CoreLocation

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)

            let initialViewController = VenueListAssembly.configure()
            let navigationVC = UINavigationController(rootViewController: initialViewController)

            window.rootViewController = navigationVC
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

