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
    private let _mutableIsAvaliable = MutableProperty(BookStatus(rawValue: "Not Avaliable")!)
    private let _mutableImage = MutableProperty(UIImage(named: "default_image"))
    let isAvaliable: Property<BookStatus>
    let image: Property<UIImage?>
    
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
        
        isAvaliable = Property(_mutableIsAvaliable)
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
                self._mutableIsAvaliable.value = res
            case .failure:
                self._mutableIsAvaliable.value = BookStatus(rawValue: "Not Avaliable")!
            }
        }
    }
    
    // MARK: - Public methods
    
    func getBookStatus() -> SignalProducer<BookStatus, RepositoryError> {
        return self._userBookRepository.booksRepository.getBookStatus(id: _book.id)
    }
    
    func rentBook() -> SignalProducer<RawDataResponse, RepositoryError> {
        return self._userBookRepository.userRepository.rentBook(id: _book.id)
    }
    
    func addBookToWishlit()-> SignalProducer<RawDataResponse, RepositoryError> {
        return self._userBookRepository.userRepository.addBookToWishlist(id: _book.id)
    }
    
}
