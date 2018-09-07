//
//  BookCommentsViewModel.swift
//  WBooks
//
//  Created by Carolina Arcos on 9/4/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import ReactiveSwift
import Networking
import Result

class BookCommentsViewModel {
    
    // MARK: - Properties
    
    private let _book: Book
    private let _booksRepository: BooksRepositoryType
    private let _mutableComments = MutableProperty([Comment]())
    private let _errors: Signal<RepositoryError, NoError>.Observer
    let comments: Property<[Comment]>
    let errors: Signal<RepositoryError, NoError>
    
    // MARK: - Initializers
    
    init(book: Book, booksRepository: BooksRepositoryType) {
        _book = book
        _booksRepository = booksRepository
        comments = Property(_mutableComments)
        (errors, _errors) = Signal<RepositoryError, NoError>.pipe()
    }
    
    deinit {
        _errors.sendCompleted()
    }
    
    // MARK: - Public methods
    
    func getBookComments() {
        self._booksRepository.getBookComments(id: _book.id)
            .startWithResult({ (result) in
            switch result {
            case let .success(comments):
                self._mutableComments.value = comments
            case let .failure(error):
                self._errors.send(value: error)
            }
        })
    }
}
