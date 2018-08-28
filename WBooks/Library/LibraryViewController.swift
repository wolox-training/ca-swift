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
        static let tablePositionY: CGFloat = 40
        static let defultEdgeValue: CGFloat = 0
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
        
        load(childViewController: booksViewcontroller,
             into: self.view,
             with: UIEdgeInsets(top: Constants.tablePositionY,
                                left: Constants.defultEdgeValue,
                                bottom: Constants.defultEdgeValue,
                                right: Constants.defultEdgeValue),
             in: .front,
             layout: .constraints,
             respectSafeArea: true)
    }
}
