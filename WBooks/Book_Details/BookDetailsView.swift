//
//  BookDetailsView.swift
//  WBooks
//
//  Created by Carolina Arcos on 8/30/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit
import WolmoCore
import ReactiveSwift
import Result

class BookDetailsView: UIView, NibLoadable {
    
    // MARK: - Constants
    
    struct Constants {
        static let availableText = "Avaliable"
        static let notAvaliableText = "Not Avaliable"
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var bookCoverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var addToWishlistButton: UIButton!
    @IBOutlet weak var rentButton: UIButton!
    
    // MARK: - Helper methods
    
    func configureBookDetails(with book: Book) {
        titleLabel.text = book.title
        statusLabel.text = book.available ? Constants.availableText : Constants.notAvaliableText
        authorLabel.text = book.author
        releaseYearLabel.text = book.releaseYear
        genreLabel.text = book.genre
        
        if let imageURL = book.imageUrl {
            let imageFetcher = ImageFetcher()
            let imageResult: SignalProducer<UIImage, NoError> = imageFetcher.fetchImage(imageURL)
                .liftError()
                .take(during: self.reactive.lifetime)
            self.bookCoverImageView.reactive.image <~ imageResult
        }
    }
}
