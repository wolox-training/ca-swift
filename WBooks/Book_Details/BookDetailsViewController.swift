//
//  BookDetailsViewController.swift
//  WBooks
//
//  Created by Carolina Arcos on 9/3/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit

class BookDetailsViewController: UIViewController {
    
    // MARK: - Constants
    
    struct Constants {
        static let headerImageHeight: CGFloat = 30
    }
    
    // MARK: - Properties
    
    private lazy var _view: BookDetailsView = BookDetailsView.loadFromNib()!
    private let _bookViewModel: BookDetailsViewModel
    private lazy var _bookInformationViewController = BookInformationViewController(bookViewModel: self._bookViewModel.createBookInformatonViewModel())
    
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
        
        addHeaderImage()
        
        load(childViewController: _bookInformationViewController,
             into: _view.informationContainerView,
             with: UIEdgeInsets(top: 0,
                                left: 0,
                                bottom: 0,
                                right: 0),
             respectSafeArea: true)
        
        _view.informationHeigthConstraint.constant = _bookInformationViewController.getViewHeigth()
    }
    
    // MARK: - Private Methods
    
    private func addHeaderImage() {
        let headerImage = UIImageView(image: GeneralConstants.Design.navigationBarImage)
        headerImage.contentMode = .bottom
        headerImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerImage)
        
        NSLayoutConstraint.activate([headerImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     headerImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     headerImage.topAnchor.constraint(equalTo: view.topAnchor),
                                     headerImage.heightAnchor.constraint(equalToConstant: Constants.headerImageHeight)
            ])
    }

}
