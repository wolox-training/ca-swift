//
//  ViewController.swift
//  WBooks
//
//  Created by Guido Marucci Blas on 4/3/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import UIKit

final class ViewController: UITabBarController {
    
    // MARK: - Constants
    
    struct Constants {
        static let libraryName = "Library"
        static let libraryImage = "ic_library"
        static let librarySelectedImage = " ic_library_active"
        static let wishlistName = "Wishlist"
        static let wishlistImage = "ic_wishlist"
        static let wishlistSelectedImage = " ic_wishlist_active"
        static let addNewName = "Add Name"
        static let addNewImage = "ic_add_new"
        static let addNewSelectedImage = " ic_add_new_active"
        static let rentalsName = "Rentals"
        static let rentalsImage = "ic_rentals"
        static let rentalsSelectedImage = "ic_rentals_active"
    }
    
    // MARK: - Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        setupTabBarItems()
    }
    
    // MARK: Private methods
    
    private func setupTabBarItems() {
        var tabBarControllers = [UIViewController]()
        
        let libraryViewController = UIViewController()
        libraryViewController.title = Constants.libraryName
        libraryViewController.tabBarItem = UITabBarItem(title: Constants.libraryName,
                                                        image: UIImage(named: Constants.libraryImage),
                                                        selectedImage: UIImage(named: Constants.librarySelectedImage))
        
        tabBarControllers.append(libraryViewController)
        
        let wishlistViewController = UIViewController()
        wishlistViewController.title = Constants.wishlistName
        wishlistViewController.tabBarItem = UITabBarItem(title: Constants.wishlistName,
                                                         image: UIImage(named: Constants.wishlistImage),
                                                         selectedImage: UIImage(named: Constants.wishlistSelectedImage))
        
        tabBarControllers.append(wishlistViewController)
        
        let addNewViewController = UIViewController()
        addNewViewController.title = Constants.addNewName
        addNewViewController.tabBarItem = UITabBarItem(title: Constants.addNewName,
                                                       image: UIImage(named: Constants.addNewImage),
                                                       selectedImage: UIImage(named: Constants.addNewSelectedImage))
        
        tabBarControllers.append(addNewViewController)
        
        let rentalsViewController = UIViewController()
        rentalsViewController.title = Constants.rentalsName
        rentalsViewController.tabBarItem = UITabBarItem(title: Constants.rentalsName,
                                                        image: UIImage(named: Constants.rentalsImage),
                                                        selectedImage: UIImage(named: Constants.rentalsSelectedImage))
        
        tabBarControllers.append(rentalsViewController)
        
        self.viewControllers = tabBarControllers
    }
}
