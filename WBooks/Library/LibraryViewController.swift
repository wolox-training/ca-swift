//
//  LibraryViewController.swift
//  WBooks
//
//  Created by Carolina Arcos on 8/21/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit

class LibraryViewController: UIViewController {
    
    // MARK: - Constants
    
    struct Constants {
        static let tableTopMargin: CGFloat = 40
        static let tableDefaultMargin: CGFloat = 0
        static let headerImageHeight: CGFloat = 30
    }
    
    // MARK: - Properties
    
    private let _libraryViewModel: LibraryViewModel!
    private lazy var _booksViewcontroller = BooksTableViewController(booksViewModel: self._libraryViewModel.createBooksViewModel())
    
    // MARK: - Initializers
    
    init(libraryViewModel: LibraryViewModel) {
        _libraryViewModel = libraryViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = GeneralConstants.Design.backgroundBlueColor
        
        addHeaderImage()
        
        load(childViewController: _booksViewcontroller,
             into: self.view,
             with: UIEdgeInsets(top: Constants.tableTopMargin,
                                left: Constants.tableDefaultMargin,
                                bottom: Constants.tableDefaultMargin,
                                right: Constants.tableDefaultMargin),
             respectSafeArea: true)
    }
    
    private func addHeaderImage() {
        let headerImage = UIImageView(image: GeneralConstants.Design.navigationBarImage)
        headerImage.contentMode = .bottom
        headerImage.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(headerImage)
        
        NSLayoutConstraint.activate([headerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     headerImage.topAnchor.constraint(equalTo: view.topAnchor),
                                     headerImage.widthAnchor.constraint(equalTo: view.widthAnchor),
                                     headerImage.heightAnchor.constraint(equalToConstant: Constants.headerImageHeight)
                                     ])
    }
}
