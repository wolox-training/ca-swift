//
//  BookDetailsViewController.swift
//  WBooks
//
//  Created by Carolina Arcos on 9/3/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit
import ReactiveSwift

enum BookStatus: String {
    case avaliable = "Avaliable"
    case notAvaliable = "Not Avaliable"
    
    var textColor: UIColor {
        switch self {
        case .avaliable:
            return UIColor(hex: "A5CD39")!
        case .notAvaliable:
            return UIColor(hex: "D0021B")!
        }
    }
    
    var rentEnabled: Bool {
        switch self {
        case .avaliable:
            return true
        case .notAvaliable:
            return false
        }
    }
}

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
                self._bookViewModel.addBookToWishlit().startWithResult({ (result) in
                    switch result {
                    case .success:
                        //TODO: show success message
                        print("Add to wishlit success")
                    case .failure:
                        // TODO: show failure message
                        print("Add to wishlist failure")
                    }
                })
        }
    }
    
    private func bindRentButtonAction() {
        self._view.rentButton.reactive.controlEvents(.touchUpInside)
            .take(during: self.reactive.lifetime)
            .observeValues { [unowned self] _ in
                self._bookViewModel.rentBook().startWithResult({ (result) in
                    switch result {
                    case .success:
                        //TODO: show success message
                        print("Rent success")
                    case .failure:
                        // TODO: show failure message
                        print("Rent failure")
                    }
                })
        }
    }
    
    // MARK: - Helper Methods
    
    func configureDetails() {
        _view.titleLabel.text = _bookViewModel.title
        _view.authorLabel.text = _bookViewModel.author
        _view.releaseYearLabel.text = _bookViewModel.year
        _view.genreLabel.text = _bookViewModel.genre
        _view.bookCoverImageView.reactive.image <~ _bookViewModel.image
        _view.statusLabel.text = "aaa"
        _view.rentButton.reactive.isEnabled <~ _bookViewModel.isRentButtonEnabled
        _view.statusLabel.reactive.text <~ _bookViewModel.isAvaliableText
//        _view.statusLabel.reactive.textColor <~ _bookViewModel.isAvailableColor

    }
    
    func getViewHeigth() -> CGFloat {
        return _view.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
    }
}
