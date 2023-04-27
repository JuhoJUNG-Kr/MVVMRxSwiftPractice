//
//  Coodinator.swift
//  MVVMRxSwiftPractice
//
//  Created by 정주호 on 24/04/2023.
//

import UIKit

class Coodinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    //rootViewController 시작 화면으로 지정 -> Scene delegate에서 start 함수 호출
    func start() {
        let rootViewController = RootViewController(viewModel: RootViewModel(articleService: ArticleService()))
        let navigationRootViewController = UINavigationController(rootViewController: rootViewController)
        window.rootViewController = navigationRootViewController
        window.makeKeyAndVisible()
    }
}
