//
//  RootViewModel.swift
//  MVVMRxSwiftPractice
//
//  Created by 정주호 on 27/04/2023.
//

import Foundation
import RxSwift

final class RootViewModel {
    
     let title = "Juho News"
    
//    private let articleService = ArticleService()
//    이렇게 만들어도 되지만 실무에선 잘 사용하지 않는다. 테스트 하기 용이하게,
//    아키텍쳐를 재사용하기 용이하게 하기 위해 그리고 확장성이 용이하게 프로토콜 타입으로 만들어주는 것을 선호하는 편
    
    //때문에, 프로토콜형태로 뷰 모델에 가져와아한다.
    private let articleService: ArticleServiceProtocol
    
    init(articleService: ArticleServiceProtocol) {
        self.articleService = articleService
    }
    
    //고차함수를 이용하여 fetchNews()로 받아온 전체 데이터를 articleViewModel 안의 각각의 article로 분배를 함
    func fetchArticles() -> Observable<[ArticleViewModel]> {
        articleService.fetchNews().map{ $0.map{ ArticleViewModel(article: $0)}}
    }
}
