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
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .systemBackground
        return cv
    }()
    
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
        view.addSubview(collectionView)
        self.title = self.viewModel.title
        navigationController?.navigationBar.backgroundColor = .systemBackground
        configureCollectionView()
    }
    
    func configureCollectionView() {
        self.collectionView.register(ArticleCollectionViewCell.self,
                                     forCellWithReuseIdentifier: ArticleCollectionViewCell.identifier)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
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
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }.disposed(by: disposeBag)
    }
}

extension RootViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.articleViewModel.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCollectionViewCell.identifier, for: indexPath) as! ArticleCollectionViewCell
        
        //셀들을 반환할 때, 이미지가 겹칠 수 있기 때문에 이미지 값은 항상 nil로 초기화
        cell.imageView.image = nil
        
        let articleViewModel = self.articleViewModel.value[indexPath.row]
        //onNext로 뷰 모델을 바꿔줌
        cell.viewModel.onNext(articleViewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
    
}
