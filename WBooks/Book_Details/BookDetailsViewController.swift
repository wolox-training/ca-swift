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
    
    // MARK - Initiaizers
    
    override func loadView() {
        self.view = _view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
