//
//  BooksTableViewController.swift
//  WBooks
//
//  Created by Carolina Arcos on 8/17/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit

class BooksTableViewController: UIViewController {
    
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
}

// MARK: - Delegate and DataSource implementation

extension BooksTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = _view.tableView.dequeue(cell: BookTableViewCell.self)!
        
        cell.configureCell()
        
        return cell
    }
}
