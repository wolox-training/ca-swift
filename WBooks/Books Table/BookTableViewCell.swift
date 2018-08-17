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
    
    // MARK:  - Properties
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell() {
        nameLabel.text = "Hola"
        authorLabel.text = "Mundo"
    }
}
