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

class BookCommentsViewModel {
    
    // MARK: - Properties
    
    private let _book: Book
    private let _booksRepository: BooksRepositoryType
    private let _mutableComments = MutableProperty([Comment]())
    let comments: Property<[Comment]>
    
    // MARK: - Initializers
    
    init(book: Book, booksRepository: BooksRepositoryType) {
        _book = book
        _booksRepository = booksRepository
        
        comments = Property(_mutableComments)
    }
    
    // MARK: - Public methods
    
    func getBookComments() {
        self._booksRepository.getBookComments(id: _book.id).startWithResult({ (result) in
            switch result {
            case let .success(comments):
                self._mutableComments.value = comments
            case let .failure(_):
                print("error")
            }
        })
    }
}
