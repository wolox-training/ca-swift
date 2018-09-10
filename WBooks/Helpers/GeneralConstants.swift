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
        static let navigationBarTitleFont = UIFont(name: "SFUIText-Semibold", size: 17)!
        static let appDefaultImage = UIImage(named: "default_image")!
        static let navigationBarImage = UIImage(named: "bc_nav bar")!
        static let headerImageHeight: CGFloat = 30
        static let buttonCornerRadius: CGFloat = 20
        static let buttonBorderWidth: CGFloat = 1
    }
    
    struct Texts {
        static let errorAlertTitle = "Error"
        static let errorAlertButtonTitle = "OK"
    }
}
