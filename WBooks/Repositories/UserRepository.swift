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
    
    func rentBook(id: Int) -> SignalProducer<RawDataResponse, RepositoryError>
    func addBookToWishlist(id: Int) -> SignalProducer<RawDataResponse, RepositoryError>
}

class UserRepository: AbstractRepository, UserRepositoryType {
    
    // MARK: - Constants
    
    struct Constants {
        static let usersPath = "users"
        static let defaultUserId = 51
    }
    
    // MARK: - Consuming methods
    
    func rentBook(id: Int) -> SignalProducer<RawDataResponse, RepositoryError> {
        let path = Constants.usersPath + "/\(Constants.defaultUserId)/rents"
        let parameters: [String: Any] = ["user_id": Constants.defaultUserId,
                                         "book_id": id]
        return performRequest(method: .post, path: path, parameters: parameters)
    }
    
    func addBookToWishlist(id: Int) -> SignalProducer<RawDataResponse, RepositoryError> {
        let path = Constants.usersPath + "\(Constants.defaultUserId)/wishes"
        let parameters: [String: Any] = ["wish": ["book_id": id,
                                                  "user_id": Constants.defaultUserId]]
        return performRequest(method: .post, path: path, parameters: parameters)
    }
}
