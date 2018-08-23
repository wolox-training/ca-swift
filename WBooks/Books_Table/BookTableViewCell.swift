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

    // MARK: - Initializers
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Helper methods
    
    func configureCell() {
        nameLabel.text = "This is the title and is so large"
        authorLabel.text = "And this is the author"
        logoImageView.image = UIImage(named: "image")
    }
}
