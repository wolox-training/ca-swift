//
//  UserRepositoryMock.swift
//  WBooksTests
//
//  Created by Carolina Arcos on 9/11/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import ReactiveSwift
import Networking

@testable import WBooks

class UserRepositoryMock: UserRepositoryType {
    var expectedError: Bool = false
    
    func rentBook(id: Int) -> SignalProducer<Rent, RepositoryError> {
        if expectedError {
            return SignalProducer(error: RepositoryError.invalidURL)
        } else {
            return SignalProducer(value: SuccessfulRent)
        }
    }
    
    func addBookToWishlist(id: Int) -> SignalProducer<Void, RepositoryError> {
        return SignalProducer.empty
    }
}
