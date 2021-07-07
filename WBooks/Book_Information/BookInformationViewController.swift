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
    
    // MARK: - Constants
    
    struct Constants {
        static let addToWishlisSuccessMessage = "Book added to wishlist"
        static let addToWishlisFailureMessage = "Book not added to wishlist. Try again"
        static let rentBookSuccessMessage = "Book rented"
        static let rentBookFailureMessage = "The book could not be rented. Try again"
    }
    
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
    
    private func configureDetails() {
        _view.titleLabel.text = _bookViewModel.title
        _view.authorLabel.text = _bookViewModel.author
        _view.releaseYearLabel.text = _bookViewModel.year
        _view.genreLabel.text = _bookViewModel.genre
        _view.bookCoverImageView.reactive.image <~ _bookViewModel.image
        _bookViewModel.bookStatus.producer
            .take(during: self.reactive.lifetime)
            .startWithValues( {[unowned self] in
            self._view.enableRentButton(isEnabled: $0.rentEnabled)
            self._view.setStatusTo($0)
        })
    }
    
    private func bindAddToWishlitButtonAction() {
        self._view.addToWishlistButton.reactive.controlEvents(.touchUpInside)
            .take(during: self.reactive.lifetime)
            .observeValues { [unowned self] _ in
                self._bookViewModel.addBookToWishlit().startWithResult({ [unowned self] (result) in
                    switch result {
                    case .success:
                        showMessage(Constants.addToWishlisSuccessMessage, in: self)
                    case .failure:
                        showMessage(Constants.addToWishlisFailureMessage, in: self)
                    }
                })
        }
    }
    
    private func bindRentButtonAction() {
        self._view.rentButton.reactive.controlEvents(.touchUpInside)
            .take(during: self.reactive.lifetime)
            .observeValues { [unowned self] _ in
                self._bookViewModel.rentBook().startWithResult({ [unowned self] (result) in
                    switch result {
                    case .success:
                        showMessage(Constants.rentBookSuccessMessage, in: self)
                    case .failure:
                        showMessage(Constants.rentBookFailureMessage, in: self)
                    }
                })
        }
    }
    
    // MARK: - Helper Methods
    
    func getViewHeigth() -> CGFloat {
        return _view.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
    }
}

fileprivate extension BookStatus {
    
    var rentEnabled: Bool {
        switch self {
        case .available:
            return true
        case .notAvailable:
            return false
        }
    }
}
