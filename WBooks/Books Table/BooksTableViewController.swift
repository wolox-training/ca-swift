//
//  BooksTableViewController.swift
//  WBooks
//
//  Created by Carolina Arcos on 8/17/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit

class BooksTableViewController: UIViewController {
    
    // MARK: - Constants
    
    struct Constants {
        static let rowHeight: CGFloat = 90
    }
    
    // MARK: - Properties
    
    private lazy var _view: BooksTableView = BooksTableView.loadFromNib()!
    
    override func loadView() {
        self.view = _view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _view.tableView.delegate = self
        _view.tableView.dataSource = self
        
        _view.tableView.register(cell: BookTableViewCell.self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - Delegate and DataSource implementation

extension BooksTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = _view.tableView.dequeue(cell: BookTableViewCell.self)!
        
        // Configure cell
        cell.configureCell()
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return Constants.rowHeight
//    }
}
