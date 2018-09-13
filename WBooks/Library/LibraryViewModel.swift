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
    
    private let _userBooksRepository: UserBooksRepository
    private let _imageFetcher: ImageFetcherType
    
    // MARK: - Initializers
    
    public init(userBooksRepository: UserBooksRepository, imageFetcher: ImageFetcherType) {
        _userBooksRepository = userBooksRepository
        _imageFetcher = imageFetcher
    }
    
    // MARK: - Public methods
    
    func createBooksViewModel() -> BooksViewModel {
        let getBooks: () -> SignalProducer<[Book], RepositoryError> = { [unowned self] in
            self._userBooksRepository.booksRepository.getBooks()
        }
        return BooksViewModel(getBooks: getBooks, userBooksRepository: _userBooksRepository, imageFetcher: _imageFetcher)
    }
}
