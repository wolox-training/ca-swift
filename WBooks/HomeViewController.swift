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
        static let navigationBarImage = "bc_nav bar"
        static let titleFont = "SFUIText-Semibold"
        static let titleSize: CGFloat = 17
        static let statusBarOriginX: CGFloat = 0
        static let statusBarOriginY: CGFloat = 0
        static let statusBarColor = UIColor(hex: "00ADEE")
    }
    
    // MARK: - Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        let barView = UIView(frame: CGRect(x: Constants.statusBarOriginX,
                                           y: Constants.statusBarOriginY,
                                           width: view.frame.width,
                                           height: UIApplication.shared.statusBarFrame.height))
        barView.backgroundColor = Constants.statusBarColor
        view.addSubview(barView)
        
        setupTabBarItems()
    }
    
    // MARK: Private methods
    
    private func setupTabBarItems() {
        var tabBarControllers = [UIViewController]()
        
        let libraryNavigationController = UINavigationController()
        let booksRepository = NetworkingBootstrapper.shared.createBooksRepository()
        let libraryViewModel = LibraryViewModel(libraryRepository: booksRepository)
        let libraryViewController = LibraryViewController(viewModel: libraryViewModel) 
        libraryViewController.title = Constants.libraryName.uppercased()
        setupNavigationController(viewContoller: libraryViewController)
        libraryViewController.tabBarItem = UITabBarItem(title: Constants.libraryName,
                                                        image: Constants.libraryImage,
                                                        selectedImage: Constants.librarySelectedImage)
        libraryNavigationController.viewControllers = [libraryViewController]
        
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
    
    private func setupNavigationController(viewContoller: UIViewController) {
        let navView = UIView()
        
        let title = UILabel()
        title.text = viewContoller.title
        title.textColor = UIColor.white
        title.font = UIFont(name: Constants.titleFont, size: Constants.titleSize)
        title.sizeToFit()
        title.center = navView.center
        title.textAlignment = .center
        
        let navigationImageView = UIImageView(image: UIImage(named: Constants.navigationBarImage))
        navigationImageView.contentMode = .scaleAspectFit
        navigationImageView.center = navView.center
        
        navView.addSubview(navigationImageView)
        navView.addSubview(title)
        viewContoller.navigationItem.titleView = navView
        navView.sizeToFit()
    }
}
