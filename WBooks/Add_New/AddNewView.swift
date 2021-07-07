//
//  AddNewView.swift
//  WBooks
//
//  Created by Carolina Arcos on 9/6/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

class AddNewView: UIView, NibLoadable {
    
    // MARK: - Properties
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var topicTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton! {
        didSet {
            submitButton.layer.cornerRadius = GeneralConstants.Design.buttonCornerRadius
            submitButton.setGradientBackground(enabled: true)
        }
    }
    @IBOutlet weak var bottomViewConstraint: NSLayoutConstraint! {
        didSet {
            if DeviceType() == .iPhone5_5s_5c_SE {
                bottomViewConstraint.isActive = false
            }
        }
    }
    @IBOutlet weak var buttonDistanceConstraint: NSLayoutConstraint! {
        didSet {
            if DeviceType() != .iPhone5_5s_5c_SE {
                buttonDistanceConstraint.isActive = false
            }
        }
    }
}
