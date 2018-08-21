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
        
        load(childViewController: booksViewcontroller, into: self.view)
    }
}
