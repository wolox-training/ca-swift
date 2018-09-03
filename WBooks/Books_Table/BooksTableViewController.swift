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
    private let _booksViewModel: BooksViewModel
    
    // MARK: - Initializers
    
    init(booksViewModel: BooksViewModel) {
        _booksViewModel = booksViewModel
        
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

        configureTableView(_view.tableView)
        bindViewModel(_booksViewModel)
        _booksViewModel.loadBooks()
    }
    
    // MARK: - Private methods
    
    private func configureTableView(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = Constants.estimatedRowHeight
        
        tableView.register(cell: BookTableViewCell.self)
    }
    
    private func bindViewModel(_ viewModel: BooksViewModel) {
        viewModel.books.producer
            .take(during: self.reactive.lifetime)
            .startWithValues { [unowned self] _ in
            self._view.tableView.reloadData()
        }
        
        viewModel.errorsSignal
            .take(during: self.reactive.lifetime)
            .observeValues({ [unowned self] (error) in
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
        return _booksViewModel.books.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = _view.tableView.dequeue(cell: BookTableViewCell.self)!
        
        cell.configureCell(with: _booksViewModel.books.value[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _view.tableView.deselectRow(at: indexPath, animated: true)
        
        let book = _booksViewModel.books.value[indexPath.row]
        
        let detailsView = BookDetailsViewController(bookViewModel: _booksViewModel.createBookViewModel(book: book))
        navigationController?.pushViewController(detailsView, animated: true)
    }
}
