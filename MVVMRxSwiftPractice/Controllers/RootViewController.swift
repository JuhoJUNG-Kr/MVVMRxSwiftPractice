//
//  RootViewController.swift
//  MVVMRxSwiftPractice
//
//  Created by 정주호 on 24/04/2023.
//

import UIKit

class RootViewController: UIViewController {
    // MARK: - Properties

    
    // MARK: - LifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Configures
    func configureUI() {
        view.backgroundColor = .systemBackground
    }


}
