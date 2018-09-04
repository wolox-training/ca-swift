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
    
    // MARK: - Initializers
    
    init(book: Book) {
        self._book = book
    }
    
    func createBookInformatonViewModel() -> BookInformationViewModel {
        let booksRepository = NetworkingBootstrapper.shared.createBooksRepository()
        return BookInformationViewModel(book: _book, booksRepository: booksRepository)
    }
}
