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
    
    // MARK: - Constants
    
    struct Constants {
        static let defaultImage = UIImage(named: "default_image")!
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    // MARK: - Helper methods
    
    func configureCell(with book: Book) {
        nameLabel.text = book.title
        authorLabel.text = book.author
        logoImageView.image = Constants.defaultImage
        
        if let imageURL = book.imageUrl {
            let imageFetcher = ImageFetcher()
            let imageResult: SignalProducer<UIImage, NoError> = imageFetcher.fetchImage(imageURL)
                .liftError()
                .take(until: self.reactive.prepareForReuse)
            self.logoImageView.reactive.image <~ imageResult
        }
        
    }
}
