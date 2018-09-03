//
//  BookInformationView.swift
//  WBooks
//
//  Created by Carolina Arcos on 8/30/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

class BookInformationView: UIView, NibLoadable {
    
    // MARK: - Contants
    
    struct Constants {
        static let buttonCornerRadius: CGFloat = 20
        static let buttonBorderWidth: CGFloat = 1
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var bookCoverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var addToWishlistButton: UIButton! {
        didSet {
            addToWishlistButton.layer.borderColor = GeneralConstants.Design.applicationBlueColor.cgColor
            addToWishlistButton.layer.cornerRadius = Constants.buttonCornerRadius
            addToWishlistButton.layer.borderWidth = Constants.buttonBorderWidth
        }
    }
    @IBOutlet weak var rentButton: UIButton! {
        didSet {
            rentButton.layer.cornerRadius = Constants.buttonCornerRadius
            rentButton.setGradientBackgound(colorOne: GeneralConstants.Design.applicationBlueColor, colorTwo: GeneralConstants.Design.buttonGreenColor)
        }
    }
}
