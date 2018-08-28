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
        static let estimatedRowHeight: CGFloat = 90
        static let errorAlertTitle = "Error"
        static let errorAlertButtonTitle = "OK"
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
        
        booksViewModel.loadBooks()
        
        booksViewModel.books.producer.startWithValues { [unowned self] _ in
            self._view.tableView.reloadData()
        }
        
        booksViewModel.errorsSignal.observeValues({ [unowned self] (error) in
            let alertError = UIAlertController(title: Constants.errorAlertTitle,
                                               message: error.localizedDescription,
                                               preferredStyle: .alert)
            alertError.addAction(UIAlertAction(title: Constants.errorAlertButtonTitle,
                                               style: .default,
                                               handler: nil))
            self.present(alertError, animated: true, completion: nil)
        })
    }
}

// MARK: - Delegate and DataSource implementation

extension BooksTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksViewModel.books.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = _view.tableView.dequeue(cell: BookTableViewCell.self)!
        
        cell.configureCell(with: booksViewModel.books.value[indexPath.row])
        
        return cell
    }
}
