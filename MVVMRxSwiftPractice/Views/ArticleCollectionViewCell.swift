//
//  ArticleCollectionViewCell.swift
//  MVVMRxSwiftPractice
//
//  Created by 정주호 on 28/04/2023.
//

import UIKit
import RxSwift
import SDWebImage

class ArticleCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "ArticleCollectionViewCell"
    var viewModel = PublishSubject<ArticleViewModel>()
    let disposeBag = DisposeBag()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        return label
    }()
    
    // MARK: - LifeCycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureAutoLayout()
        subscribe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func subscribe() {
        self.viewModel.subscribe(onNext: { articleViewModel in
            if let urlString = articleViewModel.imageUrl {
                self.imageView.sd_setImage(with: URL(string: urlString))
            }
            self.titleLabel.text = articleViewModel.title
            self.descriptionLabel.text = articleViewModel.description
        }).disposed(by: disposeBag)
    }
    
    
    // MARK: - Configures
    
    func configureUI() {
        backgroundColor = .systemBackground
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
    }
    
    func configureAutoLayout() {
        NSLayoutConstraint.activate([
            //imageView
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: leftAnchor, constant: 45),
            
            //titleLabel
            titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -40),
            
            //descriptionLabel
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor, constant: 10),
            descriptionLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor)
        ])
    }
    
    
}
