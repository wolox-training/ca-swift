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
    func getBookComments(id: Int) -> SignalProducer<[Comment], RepositoryError>
    func submitBook() -> SignalProducer<Void, RepositoryError>
}

class BooksRepository: AbstractRepository, BooksRepositoryType {
    
    // MARK: - Constants
    
    struct Constants {
        static let booksList = "books"
        static let bookSuggestion = "book_suggestions"
    }
    
    // MARK: - Consuming methods
    
    func getBooks() -> SignalProducer<[Book], RepositoryError> {
        return performRequest(method: .get, path: Constants.booksList) { decode($0).toResult() }
    }
    
    func getBookStatus(id: Int) -> SignalProducer<BookStatus, RepositoryError> {
        let path = Constants.booksList + "/\(id)/rents"
        let result: SignalProducer<[Rent], RepositoryError> = performRequest(method: .get, path: path) { decode($0).toResult() }
        
        let resultBool: SignalProducer<Bool, RepositoryError> = result.map({ rents in
            let rent = rents.filter({ (rent) in
                rent.returnedDate != .none
            }).first
            return rent != nil
        })
    
        let resultStatus: SignalProducer<BookStatus, RepositoryError> = resultBool.map({ resBool in
            return resBool ? BookStatus.available : BookStatus.notAvailable
        })
        return resultStatus
    }
    
    func getBookComments(id: Int) -> SignalProducer<[Comment], RepositoryError> {
        let path = Constants.booksList + "/\(id)/comments"
        return performRequest(method: .get, path: path) { decode($0).toResult()}
    }

    func submitBook() -> SignalProducer<Void, RepositoryError> {
        return SignalProducer(value: ())
    }
}
