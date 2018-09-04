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
    func getBookStatus(id: Int)
    func rentBook(id: Int)
    func addBookToWishlist(id: Int)
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
    
    func getBookStatus(id: Int) {
        let path = Constants.booksList + "/\(id)/rents"
//        let result = performRequest(method: .get, path: path) { decode($0). }
    }
    
    func rentBook(id: Int) {
        print("Book rented")
        // TODO: rent book
    }
    
    func addBookToWishlist(id: Int) {
        print("Book added")
        // TODO: add book to wishlist
    }
    
}
