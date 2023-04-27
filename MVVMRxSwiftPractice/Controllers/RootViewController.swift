//
//  RootViewController.swift
//  MVVMRxSwiftPractice
//
//  Created by 정주호 on 24/04/2023.
//

import UIKit
import RxSwift
import RxRelay

class RootViewController: UIViewController {
    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    let viewModel: RootViewModel
    
    //ArticleViewModel에서 받아올 데이터를 담을 바구니를 만듬
    private let articleViewModel = BehaviorRelay<[ArticleViewModel]>(value: [])
    //그 바구니를 계속 감시할 감시자를 생성함
    var articleViewModelObserver: Observable<[ArticleViewModel]> {
        return articleViewModel.asObservable()
    }
    
    // MARK: - LifeCycles
    
    //위에서 viewModel을 RootViewModel 타입으로 생성한뒤 아래 init 생성자에서 확실하게 말해줌 "너는 그냥 전달 받을 뿐이다."
    init(viewModel: RootViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchArticles()
        subscribe()
    }
    
    // MARK: - Configures
    func configureUI() {
        view.backgroundColor = .systemBackground
    }
    
    // MARK: - Helpers
    
    func fetchArticles() {
        viewModel.fetchArticles().subscribe { articleViewModels in
            self.articleViewModel.accept(articleViewModels)
        }.disposed(by: disposeBag)
    }
    
    func subscribe() {
        self.articleViewModelObserver.subscribe { articles in
            //collectionView.reload 해주기
            print(articles)
        }.disposed(by: disposeBag)
    }
}



