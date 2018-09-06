//
//  AddNewViewController.swift
//  WBooks
//
//  Created by Carolina Arcos on 9/6/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit

class AddNewViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var _view: AddNewView = AddNewView.loadFromNib()!
    private let _addNewViewModel: AddNewViewModel

    // MARK: - Initializers
    
    init(addNewViewModel: AddNewViewModel) {
        _addNewViewModel = addNewViewModel
        
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

        // Do any additional setup after loading the view.
    }
}
