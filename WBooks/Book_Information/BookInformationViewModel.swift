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

class BookInformationViewModel {
    
    // MARK: - Properties
    
    private let book: Book
    let image = MutableProperty(UIImage(named: "default_image"))
    
    var title: String {
        return book.title
    }
    
    var status: String {
        return book.available ? "Avaliable" : "Not Avaliable"
    }
    
    var statusColor: UIColor {
        return (book.available ? UIColor(hex: "A5CD39") : UIColor(hex: "D0021B"))!
    }
    
    var author: String {
        return book.author
    }
    
    var year: String {
        return book.releaseYear
    }
    
    var genre: String {
        return book.genre
    }
    
    // MARK: - Initializers
    
    init(book: Book) {
        self.book = book
        
        setImage()
    }
    
    private func setImage() {
        if let imageURL = book.imageUrl {
            let imageFetcher = ImageFetcher()
            let imageResult: SignalProducer<UIImage, NoError> = imageFetcher.fetchImage(imageURL)
                .liftError()
                .take(duringLifetimeOf: self)
            self.image <~ imageResult
        }
    }
    
}
