//
//  LibraryViewModel.swift
//  WBooks
//
//  Created by Carolina Arcos on 8/21/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import ReactiveSwift
import Networking

class LibraryViewModel {
    
    // MARK: - Properties
    
    private let _booksRespository: BooksRepositoryType
    
    // MARK: - Initializers
    
    public init(libraryRepository: BooksRepositoryType) {
        _booksRespository = libraryRepository
    }
    
    // MARK: - Public methods
    
    func createBooksViewModel() -> BooksViewModel {
        let getBooks: () -> SignalProducer<[Book], RepositoryError> = { [unowned self] in
            self._booksRespository.getBooks()
        }
        return BooksViewModel(getBooks: getBooks)
    }
}
