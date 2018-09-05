//
//  BookTableViewCell.swift
//  WBooks
//
//  Created by Carolina Arcos on 8/17/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit
import WolmoCore
import ReactiveSwift
import Result

class BookTableViewCell: UITableViewCell, NibLoadable {
    
    // MARK: - Properties
    
    @IBOutlet weak var bookCoverImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    // MARK: - Helper methods
    
    func configureCell(with book: Book) {
        nameLabel.text = book.title
        authorLabel.text = book.author
        bookCoverImageView.image = GeneralConstants.Design.appDefaultImage
        
        if let imageURL = book.imageUrl {
            let imageFetcher = ImageFetcher()
            let imageResult: SignalProducer<UIImage, NoError> = imageFetcher.fetchImage(imageURL)
                .liftError()
                .take(until: self.reactive.prepareForReuse)
            self.bookCoverImageView.reactive.image <~ imageResult
        }
    }
}
