//
//  BooksTableViewController.swift
//  WBooks
//
//  Created by Carolina Arcos on 8/17/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit
import Result
import ReactiveSwift
import ReactiveCocoa

class BooksTableViewController: UIViewController {
    
    // MARK: - Constants
    
    struct Constants {
        static let estimatedRowHeight: CGFloat = 90
    }
    
    // MARK: - Properties
    
    private lazy var _view: BooksTableView = BooksTableView.loadFromNib()!
    let booksViewModel: BooksViewModel
    
    // MARK: - Initializers
    
    init(viewModel: BooksViewModel) {
        booksViewModel = viewModel
        
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
        
        _view.tableView.delegate = self
        _view.tableView.dataSource = self
        
        _view.tableView.rowHeight = UITableViewAutomaticDimension
        _view.tableView.estimatedRowHeight = Constants.estimatedRowHeight
        
        _view.tableView.register(cell: BookTableViewCell.self)
        
        booksViewModel.mutableBooks.producer.startWithValues { _ in
            self._view.tableView.reloadData()
        }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        booksViewModel.loadBooks()
//    }
}

// MARK: - Delegate and DataSource implementation

extension BooksTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        var count: Int = 0
//        booksViewModel.loadBooks().startWithResult( { result in
//            switch result {
//            case let .success(array):
//                count = array.count
//            case let .failure(_):
//                count = 0
//            }})
//        return count
        return booksViewModel.mutableBooks.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = _view.tableView.dequeue(cell: BookTableViewCell.self)!
        
        cell.configureCell(with: booksViewModel.mutableBooks.value[indexPath.row])
        
        return cell
    }
}
