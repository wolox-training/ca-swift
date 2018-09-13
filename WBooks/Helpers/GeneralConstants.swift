//
//  GeneralConstants.swift
//  WBooks
//
//  Created by Carolina Arcos on 8/30/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit

struct GeneralConstants {
    
    struct Design {
        static let backgroundBlueColor = UIColor(hex: "EAF6FA")!
        static let applicationBlueColor = UIColor(hex: "00ADEE")!
        static let textfieldGrayColor = UIColor(hex: "C8C7CC")!
        static let navigationBarTitleFont = UIFont(name: "SFCompactDisplay-Bold", size: 17)!
        static let textFont = UIFont(name: "SFCompactText-Regular", size: 15)!
        static let placeholderFont = UIFont(name: "SFCompactText-MediumItalic", size: 15)!
        static let appDefaultImage = UIImage(named: "default_image")!
        static let navigationBarImage = UIImage(named: "bc_nav bar")!
        static let headerImageHeight: CGFloat = 30
        static let buttonCornerRadius: CGFloat = 20
        static let buttonBorderWidth: CGFloat = 1
        static let minimumDeviceHeight: CGFloat = 568
    }
    
    struct Texts {
        static let errorAlertTitle = "Error"
        static let errorAlertButtonTitle = "OK"
    }
}
