//
//  BooksViewModel.swift
//  WBooks
//
//  Created by Carolina Arcos on 8/24/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import ReactiveCocoa
import ReactiveSwift
import Result
import Networking

class BooksViewModel {
    
    // MARK: - Properties
    
    private let mutableBooks = MutableProperty([Book]())
    private let _error: Signal<RepositoryError, NoError>.Observer
    let books: Property<[Book]>
    let errorSignal: Signal<RepositoryError, NoError>
    let getBooks: () -> SignalProducer<[Book], RepositoryError>
    
    // MARK: - Initializers
    
    init(getBooks: @escaping () -> SignalProducer<[Book], RepositoryError>) {
        self.getBooks = getBooks
        books = Property(mutableBooks)
        (errorSignal, _error) = Signal<RepositoryError, NoError>.pipe()
        loadBooks()
    }
    
    deinit {
        _error.sendCompleted()
    }
    
    // MARK: - Helper methods
    
    func loadBooks() {
        self.getBooks().startWithResult { (result) in
            switch result {
            case let .success(array):
                self.mutableBooks.value = array
            case let .failure(error):
                self._error.send(value: error)
            }
        }
    }
}
