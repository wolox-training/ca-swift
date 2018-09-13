//
//  LineTextField.swift
//  WBooks
//
//  Created by Carolina Arcos on 9/10/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit

class LineTextField: UITextField {
    
    // MARK: - Initializers
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        configureTextField()
        createBorder()
    }
    required override init(frame: CGRect) {
        super.init(frame: frame)
        configureTextField()
        createBorder()
    }
    
    // MARK: - Private methods
    
    private func configureTextField() {
        borderStyle = .none
        textAlignment = .left
        font = GeneralConstants.Design.textFont
        textColor = UIColor.darkGray
        attributedPlaceholder = NSAttributedString(string: placeholder!, attributes: [NSAttributedStringKey.font: GeneralConstants.Design.textFont,
                                                                                      NSAttributedStringKey.foregroundColor: UIColor(hex: "C8C7CC")!])
    }
    
    private func createBorder() {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor(hex: "C8C7CC")!.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: frame.size.width, height: frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
