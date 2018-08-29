//
//  BooksRepository.swift
//  WBooks
//
//  Created by Carolina Arcos on 8/21/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import ReactiveSwift
import Networking
import Argo

protocol BooksRepositoryType {
    
    func getBooks() -> SignalProducer<[Book], RepositoryError>
}

class BooksRepository: AbstractRepository, BooksRepositoryType {
    
    // MARK: - Constants
    
    struct Constants {
        static let booksList = "books"
    }
    
    // MARK: - Consuming methods
    
    func getBooks() -> SignalProducer<[Book], RepositoryError> {
        return performRequest(method: .get, path: Constants.booksList) { decode($0).toResult() }
    }
    
}
