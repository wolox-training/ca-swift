//
//  UIViewController.swift
//  WolmoCore
//
//  Created by Guido Marucci Blas on 5/7/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import UIKit
public extension UIView {
    
    /**
     Loads the view into the specified containerView.
     
     - parameter containerView: The container view.
     - parameter insets: Insets that separate self from the container view. By default, .zero.
     - parameter viewPositioning: Back or Front. By default, .front.
     - parameter layout: Enum indicating the layout mode. By default, .constraints.
     
     - note: If you decide to use constraints to determine the size, the container's frame doesn't need to be final.
     Because of this, it can be used in `loadView()`, `viewDidLoad()` or `viewWillAppear(animated:)`.
     We strongly recommend to work with constraints as a better practice than frames.
     Also, this function matches left inset to leading and right to trailing of the view.
     */
    public func add(into containerView: UIView,
                    with insets: UIEdgeInsets = .zero,
                    in viewPositioning: ViewPositioning = .front,
                    layout: LayoutMode = .constraints,
                    respectSafeArea: Bool = false) {
        
        switch layout {
        case .constraints:
            containerView.addSubview(self)
            translatesAutoresizingMaskIntoConstraints = false
            addConstraints(containerView: containerView, insets: insets, respectSafeArea: respectSafeArea)
        case .frame:
            frame = getFrame(containerView: containerView, insets: insets, respectSafeArea: respectSafeArea)
            
            containerView.addSubview(self)
        }
        
        if case viewPositioning = ViewPositioning.back {
            containerView.sendSubview(toBack: self)
        }
    }
    
    private func addConstraints(containerView: UIView, insets: UIEdgeInsets, respectSafeArea: Bool) {
        if respectSafeArea {
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: containerView.safeLayoutGuide.topAnchor, constant: insets.top),
                containerView.safeLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom),
                leadingAnchor.constraint(equalTo: containerView.safeLayoutGuide.leadingAnchor, constant: insets.left),
                containerView.safeLayoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right)
                ])
        } else {
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: containerView.topAnchor, constant: insets.top),
                containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom),
                leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: insets.left),
                containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right)
                ])
        }
    }
    
    private func getFrame(containerView: UIView, insets: UIEdgeInsets, respectSafeArea: Bool) -> CGRect {
        if respectSafeArea {
            let bounds = containerView.bounds
            let x = containerView.safeLayoutInsets.left + insets.left
            let y = containerView.safeLayoutInsets.top + insets.top
            let width = bounds.width - x - insets.right - containerView.safeLayoutInsets.right
            let height = bounds.height - y - insets.bottom - containerView.safeLayoutInsets.bottom
            return CGRect(x: x, y: y, width: width, height: height)
        } else {
            let bounds = containerView.bounds
            let x = insets.left
            let y = insets.top
            let width = bounds.width - x - insets.right
            let height = bounds.height - y - insets.bottom
            return CGRect(x: x, y: y, width: width, height: height)
        }
    }
    
}

public extension UIView {
    
    /**
     This is an extension for layout compatibility between iOS 11 and lower versions.
     If the native safe layout guide is not available, then return a regular layout guide.
     */
    public var safeLayoutGuide: UILayoutGuide {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide
        }
        else {
            let id = "\(accessibilityIdentifier ?? "").safe_layout"
            if let safeGuide = layoutGuides.filter({ $0.identifier == id }).first {
                return safeGuide
            } else {
                let safeGuide = UILayoutGuide()
                safeGuide.identifier = id
                addLayoutGuide(safeGuide)
                
                NSLayoutConstraint.activate([
                    safeGuide.leadingAnchor.constraint(equalTo: leadingAnchor),
                    safeGuide.trailingAnchor.constraint(equalTo: trailingAnchor),
                    safeGuide.topAnchor.constraint(equalTo: topAnchor),
                    safeGuide.bottomAnchor.constraint(equalTo: bottomAnchor)
                    ])
                
                return safeGuide
            }
        }
    }
    
    public var safeLayoutInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return safeAreaInsets
        } else {
            return .zero
        }
    }
}
