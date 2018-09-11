//
//  BooksRepositoryMock.swift
//  WBooksTests
//
//  Created by Carolina Arcos on 9/11/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import ReactiveSwift
import Networking

@testable import WBooks

class BooksRepositoryMock: BooksRepositoryType {
    
    var expectedError: Bool = false
    
    func getBooks() -> SignalProducer<[Book], RepositoryError> {
        if expectedError {
            return SignalProducer(error: RepositoryError.invalidURL)
        } else {
            return SignalProducer(value: [DefaultBook])
        }
    }
    
    func getBookStatus(id: Int) -> SignalProducer<BookStatus, RepositoryError> {
        if expectedError {
            return SignalProducer(error: RepositoryError.noNetworkConnection)
        } else {
            return SignalProducer(value: BookStatus.available)
        }
    }
    
    func getBookComments(id: Int) -> SignalProducer<[Comment], RepositoryError> {
        return SignalProducer.empty
    }
}
