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
    
    private let mutableBooks = MutableProperty([Book]())
    private let _errors: Signal<NSError, NoError>.Observer
    private let getBooks: () -> SignalProducer<[Book], NSError>
    let books: Property<[Book]>
    let errorsSignal: Signal<NSError, NoError>
    
    // MARK: - Initializers
    
    init(getBooks: @escaping () -> SignalProducer<[Book], NSError>) {
        self.getBooks = getBooks
        books = Property(mutableBooks)
        (errorsSignal, _errors) = Signal<NSError, NoError>.pipe()
    }
    
    deinit {
        _errors.sendCompleted()
    }
    
    // MARK: - Helper methods
    
    func loadBooks() {
        self.getBooks().startWithResult { (result) in
            switch result {
            case let .success(array):
                self.mutableBooks.value = array
            case let .failure(error):
                self._errors.send(value: error)
            }
        }
    }
}
