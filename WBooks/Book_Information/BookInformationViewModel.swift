//
//  BookInformationViewModel.swift
//  WBooks
//
//  Created by Carolina Arcos on 9/3/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift
import Result
import Networking

class BookInformationViewModel {
    
    // MARK: - Properties
    
    private let _book: Book
    private let _userBookRepository: UserBooksRepository
    private let _mutableBookStatus = MutableProperty(BookStatus.notAvailable)
    private let _mutableImage = MutableProperty(GeneralConstants.Design.appDefaultImage)
    let bookStatus: Property<BookStatus>
    let image: Property<UIImage>
    
    var title: String {
        return _book.title
    }
    
    var author: String {
        return _book.author
    }
    
    var year: String {
        return _book.releaseYear
    }
    
    var genre: String {
        return _book.genre
    }
    
    // MARK: - Initializers
    
    init(book: Book, userBooksRepository: UserBooksRepository) {
        _book = book
        _userBookRepository = userBooksRepository
        
        bookStatus = Property(_mutableBookStatus)
        image = Property(_mutableImage)
        
        setImage()
        getStatusText()
    }
    
    // MARK: - Private methods
    
    private func setImage() {
        if let imageURL = _book.imageUrl {
            let imageFetcher = ImageFetcher()
            let imageResult: SignalProducer<UIImage, NoError> = imageFetcher.fetchImage(imageURL)
                .liftError()
                .take(duringLifetimeOf: self)
            self._mutableImage <~ imageResult
        }
    }
    
    private func getStatusText() {
        getBookStatus()
            .take(duringLifetimeOf: self)
            .startWithResult { [unowned self] (result) in
            switch result {
            case let .success(res):
                self._mutableBookStatus.value = res
            case .failure:
                self._mutableBookStatus.value = BookStatus.notAvailable
            }
        }
    }
    
    // MARK: - Public methods
    
    func getBookStatus() -> SignalProducer<BookStatus, RepositoryError> {
        return self._userBookRepository.booksRepository.getBookStatus(id: _book.id)
    }
    
    func rentBook() -> SignalProducer<Rent, RepositoryError> {
        return self._userBookRepository.userRepository.rentBook(id: _book.id)
    }
    
    func addBookToWishlit()-> SignalProducer<Void, RepositoryError> {
        return self._userBookRepository.userRepository.addBookToWishlist(id: _book.id)
    }
    
}
