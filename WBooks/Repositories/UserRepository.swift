//
//  UserRepository.swift
//  WBooks
//
//  Created by Carolina Arcos on 9/4/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import ReactiveSwift
import Networking

protocol UserRepositoryType {
    
    func rentBook(id: Int) -> SignalProducer<Rent, RepositoryError>
    func addBookToWishlist(id: Int) -> SignalProducer<Void, RepositoryError>
}

class UserRepository: AbstractRepository, UserRepositoryType {
    
    // MARK: - Constants
    
    struct Constants {
        static let usersPath = "users"
        static let defaultUserId = 51
    }
    
    // MARK: - Consuming methods
    
    func rentBook(id: Int) -> SignalProducer<Rent, RepositoryError> {
        return SignalProducer<Rent, RepositoryError> (value: Rent(id: 0,
                                                                  startDate: "2018-01-01",
                                                                  finalDate: "2018-02-02",
                                                                  returnedDate: nil,
                                                                  book: Book(id: 0,
                                                                             author: "Jane",
                                                                             title: "title",
                                                                             imageUrl: "jdkss",
                                                                             releaseYear: "2018",
                                                                             genre: "programming"),
                                                                  user: User(id: 0,
                                                                             firstName: "jdsehs",
                                                                             lastName: "djkshd",
                                                                             imageURL: "jkshe")))
    }
    
    func addBookToWishlist(id: Int) -> SignalProducer<Void, RepositoryError> {
        return SignalProducer(value: ())
    }
}
