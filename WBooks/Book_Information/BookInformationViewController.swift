//
//  BookDetailsViewController.swift
//  WBooks
//
//  Created by Carolina Arcos on 9/3/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit
import ReactiveSwift

class BookInformationViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var _view: BookInformationView = BookInformationView.loadFromNib()!
    private let _bookViewModel: BookInformationViewModel
    
    // MARK: - Initiaizers
    
    init(bookViewModel: BookInformationViewModel) {
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
        
        configureDetails()
        bindAddToWishlitButtonAction()
        bindRentButtonAction()
    }
    
    // MARK: - Private methods
    
    private func bindAddToWishlitButtonAction() {
        self._view.addToWishlistButton.reactive.controlEvents(.touchUpInside)
            .take(during: self.reactive.lifetime)
            .observeValues { [unowned self] _ in
                self._bookViewModel.addBookToWishlit()
        }
    }
    
    private func bindRentButtonAction() {
        self._view.rentButton.reactive.controlEvents(.touchUpInside)
        .take(during: self.reactive.lifetime)
            .observeValues { [unowned self] _ in
                self._bookViewModel.rentBook()
        }
    }
    
    // MARK: - Helper Methods
    
    func configureDetails() {
        _view.titleLabel.text = _bookViewModel.title
        _view.statusLabel.text = _bookViewModel.status
        _view.authorLabel.text = _bookViewModel.author
        _view.releaseYearLabel.text = _bookViewModel.year
        _view.genreLabel.text = _bookViewModel.genre
        _view.bookCoverImageView.reactive.image <~ _bookViewModel.image
        _view.statusLabel.textColor = _bookViewModel.statusColor
    }
    
    func getViewHeigth() -> CGFloat {
        return _view.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
    }
}
