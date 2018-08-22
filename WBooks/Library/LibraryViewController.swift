//
//  LibraryViewController.swift
//  WBooks
//
//  Created by Carolina Arcos on 8/21/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit
import WolmoCore

class LibraryViewController: UIViewController {
    
    // MARK: - Constants
    
    struct Constants {
        static let backgroundBlueColor = "EAF6FA"
        static let tablePositionY: CGFloat = 100
    }
    
    // MARK: - Properties
    
    let libraryViewModel: LibraryViewModel!
    let booksViewcontroller: BooksTableViewController
    
    // MARK: - Initializers
    
    init(viewModel: LibraryViewModel) {
        libraryViewModel = viewModel
        booksViewcontroller = BooksTableViewController()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hex: Constants.backgroundBlueColor)
        
        let childView = UIView()
        self.view.addSubview(childView)
        
        addChildViewController(booksViewcontroller)
        view.addSubview(booksViewcontroller.view)
        booksViewcontroller.view.frame = CGRect(x: view.frame.origin.x,
                                                y: view.frame.origin.y + Constants.tablePositionY,
                                                width: view.frame.width,
                                                height: view.frame.height - (tabBarController?.tabBar.frame.height ?? 0) - Constants.tablePositionY)
        
//        load(childViewController: booksViewcontroller, into: self.view)
//        self.view.addSubview(booksViewcontroller.view)
    }
}
