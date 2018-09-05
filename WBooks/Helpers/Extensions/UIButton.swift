//
//  UIButton.swift
//  WBooks
//
//  Created by Carolina Arcos on 9/3/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

extension UIButton {
    
    // MARK: - Constants
    
    struct Constants {
        static let enabledColors = [GeneralConstants.Design.applicationBlueColor, UIColor(hex: "38CCCD")!]
        static let disabledColors = [UIColor(hex: "EAEAEA")!, UIColor(hex: "F4F4F4")!]
    }
    
    // MARK: - Gradient
    
    func setGradientBackgound(enabled: Bool) {
        let colors: [UIColor]
        if enabled {
            colors = Constants.enabledColors
        } else {
            colors = Constants.disabledColors
        }
        
        self.gradient = ViewGradient(colors: colors, direction: .leftToRight)
    }
}
