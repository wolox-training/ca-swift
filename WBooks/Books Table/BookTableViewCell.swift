//
//  BookTableViewCell.swift
//  WBooks
//
//  Created by Carolina Arcos on 8/17/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

class BookTableViewCell: UITableViewCell, NibLoadable {
    
    // MARK: - Properties
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    // MARK: - Helper methods
    
    func configureCell(with book: Book) {
        nameLabel.text = book.title
        authorLabel.text = book.author
        logoImageView.image = UIImage(named: book.imageUrl) // TODO: Download image
    }
}
