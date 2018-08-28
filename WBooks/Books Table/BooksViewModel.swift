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

class BooksViewModel {
    
    // MARK: - Properties
    
    private let _mutableBooks = MutableProperty([Book]())
    private let _errors: Signal<NSError, NoError>.Observer
    private let _getBooks: () -> SignalProducer<[Book], NSError>
    let books: Property<[Book]>
    let errorsSignal: Signal<NSError, NoError>
    
    // MARK: - Initializers
    
    init(getBooks: @escaping () -> SignalProducer<[Book], NSError>) {
        self._getBooks = getBooks
        books = Property(_mutableBooks)
        (errorsSignal, _errors) = Signal<NSError, NoError>.pipe()
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
}
