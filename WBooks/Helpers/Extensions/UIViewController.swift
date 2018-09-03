//
//  UIViewController.swift
//  WolmoCore
//
//  Created by Guido Marucci Blas on 5/7/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import UIKit

/**
 Indicates the way in which the layout is set.
 */

public enum LayoutMode {
    case constraints
    case frame
}

/**
 Represents the possible positions where you can add a view into another.
 */
public enum ViewPositioning {
    case back
    case front
}

public extension UIViewController {
    
    /**
     Loads the childViewController into the specified containerView.
     
     It can be done after self's view is initialized, as it uses constraints to determine the childViewController size.
     Take into account that self will retain the childViewController, so if for any other reason the childViewController is retained in another place, this would
     lead to a memory leak. In that case, one should call unloadViewController().
     
     - parameter childViewController: The controller to load.
     - parameter into: The containerView into which the controller will be loaded.
     - parameter viewPositioning: Back or Front. Default: Front
     */
    public func load(childViewController: UIViewController,
                     into containerView: UIView,
                     with insets: UIEdgeInsets = .zero,
                     in viewPositioning: ViewPositioning = .front,
                     layout: LayoutMode = .constraints,
                     respectSafeArea: Bool = false) {
        childViewController.willMove(toParentViewController: self)
        addChildViewController(childViewController)
        childViewController.didMove(toParentViewController: self)
        childViewController.view.add(into: containerView, with: insets, in: viewPositioning, layout: layout, respectSafeArea: respectSafeArea)
    }
}
