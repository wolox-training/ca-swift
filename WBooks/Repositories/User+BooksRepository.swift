//
//  User+BooksRepository.swift
//  WBooks
//
//  Created by Carolina Arcos on 9/4/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import ReactiveSwift
import Networking

protocol UserBooksRepositoryType {
    var userRepository: UserRepositoryType { get }
    var booksRepository: BooksRepositoryType { get }
}

class UserBooksRepository: UserBooksRepositoryType {
    
    var userRepository: UserRepositoryType
    var booksRepository: BooksRepositoryType
    
    init(networkingConfiguration: NetworkingConfiguration, sessionManager: SessionManager) {
        userRepository = UserRepository(networkingConfiguration: networkingConfiguration, sessionManager: sessionManager)
        booksRepository = BooksRepository(networkingConfiguration: networkingConfiguration, sessionManager: sessionManager)
    }
}
