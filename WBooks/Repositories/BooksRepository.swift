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
    func getBookStatus(id: Int) -> SignalProducer<BookStatus, RepositoryError>
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
    
    func getBookStatus(id: Int) -> SignalProducer<BookStatus, RepositoryError> {
        let path = Constants.booksList + "/\(id)/rents"
        let result: SignalProducer<[Rent], RepositoryError> = performRequest(method: .get, path: path) { decode($0).toResult() }
        //TODO: filter [Rent] to get book status
        return SignalProducer<BookStatus, RepositoryError> { (observer, _) in
            observer.send(value: BookStatus(rawValue: "Not Avaliable")!)
            observer.sendCompleted()
        }

    }
    
}
