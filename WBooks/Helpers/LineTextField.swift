//
//  LineTextField.swift
//  WBooks
//
//  Created by Carolina Arcos on 9/10/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit

class LineTextField: UITextField {
    
    // MARK: - Properties
    
    override var placeholder: String? {
        didSet {
            configurePlaceholder()
        }
    }
    
    // MARK: - Initializers
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        configureTextField()
        _ = add(bottom: .init(thickness: 0.5, color: GeneralConstants.Design.textfieldGrayColor))
    }
    
    // MARK: - Private methods
    
    private func configureTextField() {
        borderStyle = .none
        textAlignment = .left
        font = GeneralConstants.Design.textFont
        textColor = UIColor.darkGray
        
        configurePlaceholder()
    }
    
    private func configurePlaceholder() {
        if let placeholder = placeholder {
            attributedPlaceholder = NSAttributedString(string: placeholder.capitalized, attributes: [
                NSAttributedStringKey.font: GeneralConstants.Design.placeholderFont,
                NSAttributedStringKey.foregroundColor: GeneralConstants.Design.textfieldGrayColor
                ])
        }
    }
}
