//
//  UserBooksRepositoryMock.swift
//  WBooksTests
//
//  Created by Carolina Arcos on 9/11/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation

@testable import WBooks

class UserBooksRepositoryMock: UserBooksRepositoryType {
    
    var _userRepositoryMock: UserRepositoryMock = UserRepositoryMock()
    var _booksRepositoryMock: BooksRepositoryMock = BooksRepositoryMock()
    
    var userRepository: UserRepositoryType {
        return _userRepositoryMock
    }
    var booksRepository: BooksRepositoryType {
        return _booksRepositoryMock
    }
    
}
