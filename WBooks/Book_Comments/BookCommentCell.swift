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
    
    func configureCell(with comment: Comment) {
        nameLabel.text = "\(comment.user.firstName) \(comment.user.lastName)"
        commentLabel.text = comment.comment
        userImageView.image = Constants.defaultImage
        
        if let imageURL = comment.user.imageURL {
            let imageFetcher = ImageFetcher()
            let imageResult: SignalProducer<UIImage, NoError> = imageFetcher.fetchImage(imageURL)
                .liftError()
                .take(until: self.reactive.prepareForReuse)
            userImageView.reactive.image <~ imageResult
        }
    }
    
}
