//
//  Article.swift
//  MVVMRxSwiftPractice
//
//  Created by 정주호 on 27/04/2023.
//

import Foundation

struct ArticleResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]
}

struct Article: Codable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
}
