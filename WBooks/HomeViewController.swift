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
        static let addNewImage = UIImage(named: "ic_add_new")
        static let addNewSelectedImage = UIImage(named: "ic_add_new_active")
        static let rentalsName = "Rentals"
        static let rentalsImage = UIImage(named: "ic_rentals")
        static let rentalsSelectedImage = UIImage(named: "ic_rentals_active") 
        static let navigationBarImage = UIImage(named: "bc_nav bar")
        static let statusBarOriginX: CGFloat = 0
        static let statusBarOriginY: CGFloat = 0
        static let tabBarBorderWidth: CGFloat = 0.0
    }
    
    // MARK: - Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        tabBar.tintColor = GeneralConstants.Design.navigationBlueColor
        tabBar.layer.borderWidth = Constants.tabBarBorderWidth
        tabBar.clipsToBounds = true
        
        let statusBarView = UIView(frame: CGRect(x: Constants.statusBarOriginX,
                                           y: Constants.statusBarOriginY,
                                           width: view.frame.width,
                                           height: UIApplication.shared.statusBarFrame.height))
        statusBarView.backgroundColor = GeneralConstants.Design.navigationBlueColor
        view.addSubview(statusBarView)
        
        setupTabBarItems()
    }
    
    // MARK: Private methods
    
    private func setupTabBarItems() {
        var tabBarControllers = [UIViewController]()
        let booksRepository = NetworkingBootstrapper.shared.createBooksRepository()

        let libraryViewModel = LibraryViewModel(libraryRepository: booksRepository)
        let libraryViewController = LibraryViewController(libraryViewModel: libraryViewModel) 
        libraryViewController.title = Constants.libraryName.uppercased()
        setupNavigationController(viewController: libraryViewController)
        libraryViewController.tabBarItem = UITabBarItem(title: Constants.libraryName,
                                                        image: Constants.libraryImage,
                                                        selectedImage: Constants.librarySelectedImage)
        
        let libraryNavigationController = UINavigationController(rootViewController: libraryViewController)
        tabBarControllers.append(libraryNavigationController)
        
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
    
    private func setupNavigationController(viewController: UIViewController) {
        let navView = UIView()
        
        let title = UILabel()
        title.text = viewController.title
        title.textColor = UIColor.white
        title.font = GeneralConstants.Design.navigationTitleFont
        title.sizeToFit()
        title.center = navView.center
        title.textAlignment = .center
        
        let navigationImageView = UIImageView(image: Constants.navigationBarImage)
        navigationImageView.contentMode = .scaleAspectFit
        navigationImageView.center = navView.center
        
        navView.addSubview(navigationImageView)
        navView.addSubview(title)
        navView.sizeToFit()
        viewController.navigationItem.titleView = navView
    }
}
