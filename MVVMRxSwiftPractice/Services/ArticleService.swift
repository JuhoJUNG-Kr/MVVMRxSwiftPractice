//
//  ArticleService.swift
//  MVVMRxSwiftPractice
//
//  Created by 정주호 on 27/04/2023.
//

import Foundation
import Alamofire
import RxSwift

protocol ArticleServiceProtocol {
    func fetchNews() -> Observable<[Article]>
}

//alamofire 를 사용하여 네트워크와 통신하는 기본 틀 만들기
final class ArticleService: ArticleServiceProtocol {
    //RX Swift를 이용하여 다른 콜백함수의 선언 없이 옵저버로 처리하기
    func fetchNews() -> Observable<[Article]> {
        return Observable.create { (observer) -> Disposable in
            
            self.fetchNews { error, articles in
                if let error = error {
                    //만약 에러가 있다면~ 옵저버가 에러를 발견했다는 걸 보여주세요~
                    observer.onError(error)
                }
                if let articles = articles {
                    //만약 기사가 있다면~ 다음으로 넘어가주세요~
                    observer.onNext(articles)
                }

                observer.onCompleted()
            }
            //메모리영역에서 observable 이 필요가 없어졌을 때 자동으로 지워 메모리 공간을 비워두는 역할
            return Disposables.create()
        }
    }
    
    private func fetchNews(completion: @escaping((Error?, [Article]?) -> Void)) {
        let urlString =
        "https://newsapi.org/v2/everything?q=tesla&from=2023-03-27&sortBy=publishedAt&apiKey=cbd1287a323046a3a2baad1a5003f1d5"
        
        guard let url = URL(string: urlString) else { return completion(NSError(domain: "juho293", code: 404), nil)}
        
        AF.request(url, method: HTTPMethod.get, encoding: JSONEncoding.default).responseDecodable(of: ArticleResponse.self) { response in
            if let error = response.error {
                return completion(error, nil)
            }
            
            if let articles = response.value?.articles {
                return completion(nil, articles)
            }
        }
    }
}
