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
//    private let _mutableIsAvaliable = MutableProperty(BookStatus(rawValue: "Not Avaliable")!)
    
    let isAvaliableText = MutableProperty(String())
    let isAvailableColor = MutableProperty(UIColor(hex: "D0021B"))
    let isRentButtonEnabled = MutableProperty(false)
    let image = MutableProperty(UIImage(named: "default_image"))
    
    var title: String {
        return _book.title
    }
    
//    var statusColor: UIColor {
//        return (_book.available ? UIColor(hex: "A5CD39") : UIColor(hex: "D0021B"))!
//    }
    
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
            self.image <~ imageResult
        }
    }
    
    private func getStatusText() {
        getBookStatus()
            .take(duringLifetimeOf: self)
            .startWithResult { [unowned self] (result) in
            switch result {
            case let .success(res):
                self.isAvaliableText.value = res.rawValue
                self.isAvailableColor.value = res.textColor
                self.isRentButtonEnabled.value = res.rentEnabled
//                self.isAvaliable.value = (isAvaliable ? BookStatus(rawValue: "Avaliable") : BookStatus(rawValue: "Not Avaliable"))!
            case .failure:
                self.isAvaliableText.value = "Not Available"
                self.isAvailableColor.value = UIColor(hex: "D0021B")
//                self.isAvaliable.value = BookStatus(rawValue: "Not Avaliable")!
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
