//
//  HomeViewController.swift
//  WBooks
//
//  Created by Guido Marucci Blas on 4/3/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

final class HomeViewController: UITabBarController {
    
    // MARK: - Constants
    
    struct Constants {
        static let libraryName = "Library"
        static let libraryImage = UIImage(named: "ic_library")
        static let librarySelectedImage = UIImage(named: "ic_library_active")
        static let wishlistName = "Wishlist"
        static let wishlistImage = UIImage(named: "ic_wishlist")
        static let wishlistSelectedImage = UIImage(named: "ic_wishlist_active")
        static let addNewName = "Add New"
        static let addNewImage = UIImage(named: "ic_add_new")
        static let addNewSelectedImage = UIImage(named: "ic_add_new_active")
        static let rentalsName = "Rentals"
        static let rentalsImage = UIImage(named: "ic_rentals")
        static let rentalsSelectedImage = UIImage(named: "ic_rentals_active")
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
        
        let getBooks: () -> SignalProducer<[Book], NSError> = {
            return SignalProducer(value: [Book(id: 0, author: "First author", title: "First Title", imageUrl: "image"),
                                          Book(id: 0, author: "Second author", title: "Second title", imageUrl: "image"),
                                          Book(id: 0, author: "Third author", title: "Third title", imageUrl: "image")])
        }
        let bookViewModel = BooksViewModel(getBooks: getBooks)
        let libraryViewController = BooksTableViewController(viewModel: bookViewModel)
        libraryViewController.title = Constants.libraryName
        libraryViewController.tabBarItem = UITabBarItem(title: Constants.libraryName,
                                                        image: Constants.libraryImage,
                                                        selectedImage: Constants.librarySelectedImage)
        
        tabBarControllers.append(libraryViewController)
        
        let wishlistViewController = UIViewController()
        wishlistViewController.title = Constants.wishlistName
        wishlistViewController.tabBarItem = UITabBarItem(title: Constants.wishlistName,
                                                         image: Constants.wishlistImage,
                                                         selectedImage: Constants.wishlistSelectedImage)
        
        tabBarControllers.append(wishlistViewController)
        
        let addNewViewController = UIViewController()
        addNewViewController.title = Constants.addNewName
        addNewViewController.tabBarItem = UITabBarItem(title: Constants.addNewName,
                                                       image: Constants.addNewImage,
                                                       selectedImage: Constants.addNewSelectedImage)
        
        tabBarControllers.append(addNewViewController)
        
        let rentalsViewController = UIViewController()
        rentalsViewController.title = Constants.rentalsName
        rentalsViewController.tabBarItem = UITabBarItem(title: Constants.rentalsName,
                                                        image: Constants.rentalsImage,
                                                        selectedImage: Constants.rentalsSelectedImage)
        
        tabBarControllers.append(rentalsViewController)
        
        self.viewControllers = tabBarControllers
    }
}
