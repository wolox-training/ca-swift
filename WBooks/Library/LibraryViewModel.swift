//
//  LibraryViewModel.swift
//  WBooks
//
//  Created by Carolina Arcos on 8/21/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import ReactiveCocoa
import ReactiveSwift
import Networking

class LibraryViewModel {
    
    // MARK: - Properties
    
    private let _libraryRespository:  BooksRepositoryType
    
    // MARK: - Initializers
    
    public init(libraryRepository: BooksRepositoryType) {
        _libraryRespository = libraryRepository
    }
    
    // MARK: - Public methods
    
    func createBooksViewModel() -> BooksViewModel {
        let getBooks: () -> SignalProducer<[Book], RepositoryError> = { [unowned self] in
            self._libraryRespository.getBooks()
        }
        return BooksViewModel(getBooks: getBooks)
    }
}
