//
//  ArticleViewModel.swift
//  MVVMRxSwiftPractice
//
//  Created by 정주호 on 27/04/2023.
//

import Foundation

//각각의 뉴스가 어떤 형태를 가지고 있는지 작성하기
struct ArticleViewModel {
    //뉴스는 뉴스 모델의 형태를 띄며
    private let article: Article
    //뉴스의 이미지는 뉴스모델의 urlToImage의 형태
    var imageUrl: String? {
        return article.urlToImage
    }
    //뉴스 제목은 뉴스모델의 title
    var title: String? {
        return article.title
    }
    //뉴스 설명은 뉴스모델의 description
    var description: String? {
        return article.description
    }
    
    init(article: Article) {
        self.article = article
    }
}
