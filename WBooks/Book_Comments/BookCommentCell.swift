//
//  BookCommentCell.swift
//  WBooks
//
//  Created by Carolina Arcos on 9/4/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit
import WolmoCore
import ReactiveSwift
import Result

class BookCommentCell: UITableViewCell, NibLoadable {
    
    // MARK: - Constants
    
    struct Constants {
        static let defaultImage = UIImage(named: "default_image")!
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    func configureCell() {
        nameLabel.text = "Hola"
        commentLabel.text = "Something here sjkdr adhfkjerh akjsdfkjr ak dfhakejrhk akeakhrkfj as fdergst gsrthgsrtgrt sgtrtgsfv stgs rfs  g rt gs f  fr f se v sa... end"
        userImageView.image = Constants.defaultImage
        
        if let imageURL = URL(string: "http://someurl.jpg") {
            let imageFetcher = ImageFetcher()
            let imageResult: SignalProducer<UIImage, NoError> = imageFetcher.fetchImage(imageURL)
                .liftError()
                .take(until: self.reactive.prepareForReuse)
            userImageView.reactive.image <~ imageResult
        }
    }
    
}
