//
//  BooksViewModel.swift
//  WBooks
//
//  Created by Carolina Arcos on 8/24/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result
import Networking

class BooksViewModel {
    
    // MARK: - Properties
    
    private let _mutableBooks = MutableProperty([Book]())
    private let _errors: Signal<RepositoryError, NoError>.Observer
    private let _getBooks: () -> SignalProducer<[Book], RepositoryError>
    private let _userBooksRepository: UserBooksRepository
    private let _imageFetcher: ImageFetcherType
    let books: Property<[Book]>
    let errorsSignal: Signal<RepositoryError, NoError>
    
    // MARK: - Initializers
    
    init(getBooks: @escaping () -> SignalProducer<[Book], RepositoryError>, userBooksRepository: UserBooksRepository, imageFetcher: ImageFetcherType) {
        _userBooksRepository = userBooksRepository
        _getBooks = getBooks
        _imageFetcher = imageFetcher
        books = Property(_mutableBooks)
        (errorsSignal, _errors) = Signal<RepositoryError, NoError>.pipe()
    }
    
    deinit {
        _errors.sendCompleted()
    }
    
    // MARK: - Helper methods
    
    func loadBooks() {
        self._getBooks().startWithResult { (result) in
            switch result {
            case let .success(array):
                self._mutableBooks.value = array
            case let .failure(error):
                self._errors.send(value: error)
            }
        }
    }
    
    func createBookDetailsViewModel(book: Book) -> BookDetailsViewModel {
        return BookDetailsViewModel(book: book, userBooksRepository: _userBooksRepository, imageFetcher: _imageFetcher)
    }
}
