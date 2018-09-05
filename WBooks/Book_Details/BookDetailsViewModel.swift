//
//  BookDetailsViewModel.swift
//  WBooks
//
//  Created by Carolina Arcos on 9/3/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation

class BookDetailsViewModel {
    
    // MARK: - Properties
    
    private let _book: Book
    private let _userBooksRepository: UserBooksRepository
    
    // MARK: - Initializers
    
    init(book: Book, userBooksRepository: UserBooksRepository) {
        self._book = book
        self._userBooksRepository = userBooksRepository
    }
    
    func createBookInformatonViewModel() -> BookInformationViewModel {
        return BookInformationViewModel(book: _book, userBooksRepository: _userBooksRepository)
    }
}
