//
//  HomeViewController.swift
//  WBooks
//
//  Created by Guido Marucci Blas on 4/3/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import UIKit
import ReactiveSwift

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
        static let addNewNameBook = "Add New Book"
        static let addNewImage = UIImage(named: "ic_add_new")
        static let addNewSelectedImage = UIImage(named: "ic_add_new_active")
        static let rentalsName = "Rentals"
        static let rentalsImage = UIImage(named: "ic_rentals")
        static let rentalsSelectedImage = UIImage(named: "ic_rentals_active") 
        static let defaultBarBorderWidth: CGFloat = 0.0
    }
    
    // MARK: - Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = GeneralConstants.Design.applicationBlueColor
        tabBar.layer.borderWidth = Constants.defaultBarBorderWidth
        tabBar.clipsToBounds = true
        
        setupTabBarItems()
    }
    
    // MARK: Private methods
    
    private func setupTabBarItems() {
        var tabBarControllers = [UIViewController]()
        let userBooksRepository = NetworkingBootstrapper.shared.createUserBooksRepository()

        let libraryViewModel = LibraryViewModel(userBooksRepository: userBooksRepository)
        let libraryViewController = LibraryViewController(libraryViewModel: libraryViewModel) 
        libraryViewController.title = Constants.libraryName.uppercased()
        libraryViewController.tabBarItem = UITabBarItem(title: Constants.libraryName,
                                                        image: Constants.libraryImage,
                                                        selectedImage: Constants.librarySelectedImage)
        
        tabBarControllers.append(setupNavigationController(with: libraryViewController))
        
        let wishlistViewController = UIViewController()
        wishlistViewController.title = Constants.wishlistName.uppercased()
        wishlistViewController.tabBarItem = UITabBarItem(title: Constants.wishlistName,
                                                         image: Constants.wishlistImage,
                                                         selectedImage: Constants.wishlistSelectedImage)
        
        tabBarControllers.append(wishlistViewController)
        
        let addNewViewModel = AddNewViewModel(booksRepository: userBooksRepository.booksRepository)
        let addNewViewController = AddNewViewController(addNewViewModel: addNewViewModel)
        addNewViewController.title = Constants.addNewNameBook.uppercased()
        addNewViewController.tabBarItem = UITabBarItem(title: Constants.addNewName,
                                                       image: Constants.addNewImage,
                                                       selectedImage: Constants.addNewSelectedImage)
        
        tabBarControllers.append(setupNavigationController(with: addNewViewController))
        
        let rentalsViewController = UIViewController()
        rentalsViewController.title = Constants.rentalsName.uppercased()
        rentalsViewController.tabBarItem = UITabBarItem(title: Constants.rentalsName,
                                                        image: Constants.rentalsImage,
                                                        selectedImage: Constants.rentalsSelectedImage)
        
        tabBarControllers.append(rentalsViewController)
        
        self.viewControllers = tabBarControllers
    }
    
    private func setupNavigationController(with viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.tintColor = UIColor.white
        navigationController.navigationBar.barTintColor = GeneralConstants.Design.applicationBlueColor
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.font: GeneralConstants.Design.navigationBarTitleFont,
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        
        return navigationController
    }
}
