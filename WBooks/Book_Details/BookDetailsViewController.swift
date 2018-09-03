//
//  BookDetailsViewController.swift
//  WBooks
//
//  Created by Carolina Arcos on 9/3/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit

class BookDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var _view: BookDetailsView = BookDetailsView.loadFromNib()!
    private let _bookViewModel: BookViewModel
    
    // MARK - Initiaizers
    
    init(bookViewModel: BookViewModel) {
        _bookViewModel = bookViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = _view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        _view.configureBookDetails(with: _bookViewModel.book)
    }
}
