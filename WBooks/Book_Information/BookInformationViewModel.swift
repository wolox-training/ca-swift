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
    
    let image = MutableProperty(UIImage(named: "default_image"))
    
    var title: String {
        return _book.title
    }
    
    var status: String {
        return _book.available ? "Avaliable" : "Not Avaliable"
    }
    
    var statusColor: UIColor {
        return (_book.available ? UIColor(hex: "A5CD39") : UIColor(hex: "D0021B"))!
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
        self._book = book
        self._userBookRepository = userBooksRepository
        
        setImage()
    }
    
    // MARK: - Private methods
    
    private func setImage() {
        if let imageURL = _book.imageUrl {
            let imageFetcher = ImageFetcher()
            let imageResult: SignalProducer<UIImage, NoError> = imageFetcher.fetchImage(imageURL)
                .liftError()
                .take(duringLifetimeOf: self)
            self.image <~ imageResult
        }
    }
    
    // MARK: - Public methods
    
    func getBookStatus() {
        self._userBookRepository.booksRepository.getBookStatus(id: _book.id)
    }
    
    func rentBook() -> SignalProducer<RawDataResponse, RepositoryError> {
        return self._userBookRepository.userRepository.rentBook(id: _book.id)
    }
    
    func addBookToWishlit() {
        self._userBookRepository.userRepository.addBookToWishlist(id: _book.id)
    }
    
}
