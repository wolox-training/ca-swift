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
    private let _bookViewModel: BookDetailsViewModel
    private lazy var _bookInformationViewController = BookInformationViewController(bookViewModel: self._bookViewModel.createBookInformatonViewModel())
    private lazy var _bookCommentsViewController = BookCommentsViewController(commentsViewModel: self._bookViewModel.createBookCommentsViewModel())
    
    // MARK: - Initielizers
    
    init(bookViewModel: BookDetailsViewModel) {
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
        
        addHeaderImage(to: self.view)
        
        load(childViewController: _bookInformationViewController,
             into: _view.informationContainerView,
             respectSafeArea: true)
        
        load(childViewController: _bookCommentsViewController,
             into: _view.commentsContainerView,
             respectSafeArea: true)
        
        _view.informationHeigthConstraint.constant = _bookInformationViewController.getViewHeigth()
    }
}
