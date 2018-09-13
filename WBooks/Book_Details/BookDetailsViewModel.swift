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
    private let _imageFetcher: ImageFetcherType
    
    // MARK: - Initializers
    
    init(book: Book, userBooksRepository: UserBooksRepository, imageFetcher: ImageFetcherType) {
        _book = book
        _userBooksRepository = userBooksRepository
        _imageFetcher = imageFetcher
    }
    
    func createBookInformatonViewModel() -> BookInformationViewModel {
        return BookInformationViewModel(book: _book, userBooksRepository: _userBooksRepository, imageFetcher: _imageFetcher)
    }
    
    func createBookCommentsViewModel() -> BookCommentsViewModel {
        return BookCommentsViewModel(book: _book, booksRepository: _userBooksRepository.booksRepository)
    }
}
