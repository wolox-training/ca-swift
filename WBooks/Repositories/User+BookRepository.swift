//
//  User+BookRepository.swift
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

class UserBooksRepository: AbstractRepository, UserBooksRepositoryType {
    var userRepository: UserRepositoryType = NetworkingBootstrapper.shared.createUserRepository()
    
    var booksRepository: BooksRepositoryType = NetworkingBootstrapper.shared.createBooksRepository()
    
    
}
