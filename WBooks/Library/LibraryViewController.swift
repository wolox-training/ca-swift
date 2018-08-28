//
//  LibraryViewController.swift
//  WBooks
//
//  Created by Carolina Arcos on 8/21/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit
import WolmoCore
import ReactiveCocoa
import ReactiveSwift

class LibraryViewController: UIViewController {
    
    // MARK: - Constants
    
    struct Constants {
        static let backgroundBlueColor = UIColor(hex: "EAF6FA")
        static let tablePositionYAddition: CGFloat = 40
    }
    
    // MARK: - Properties
    
    let libraryViewModel: LibraryViewModel!
    let booksViewcontroller: BooksTableViewController
    
    // MARK: - Initializers
    
    init(viewModel: LibraryViewModel) {
        libraryViewModel = viewModel
        
        let booksViewModel = libraryViewModel.createBooksViewModel()
        booksViewcontroller = BooksTableViewController(viewModel: booksViewModel)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constants.backgroundBlueColor
        
        let childView = UIView()
        self.view.addSubview(childView)
        
        addChildViewController(booksViewcontroller)
        view.addSubview(booksViewcontroller.view)
        let tableOriginY = view.frame.origin.y + (self.navigationController?.navigationBar.frame.size.height ?? 0)  + (UIApplication.shared.statusBarFrame.size.height) + Constants.tablePositionYAddition
        booksViewcontroller.view.frame = CGRect(x: view.frame.origin.x,
                                                y: tableOriginY,
                                                width: view.frame.width,
                                                height: view.frame.height - (tabBarController?.tabBar.frame.height ?? 0) - tableOriginY)
        
//        load(childViewController: booksViewcontroller, into: self.view)
//        self.view.addSubview(booksViewcontroller.view)
    }
}
