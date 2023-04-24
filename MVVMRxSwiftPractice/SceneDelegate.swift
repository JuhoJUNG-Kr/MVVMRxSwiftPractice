//
//  SceneDelegate.swift
//  MVVMRxSwiftPractice
//
//  Created by 정주호 on 24/04/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let secne = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: secne)
        let coordinator = Coodinator(window: self.window!)
        coordinator.start()
    }


}

