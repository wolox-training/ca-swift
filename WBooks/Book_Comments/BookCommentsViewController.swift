//
//  BookCommentsViewController.swift
//  WBooks
//
//  Created by Carolina Arcos on 9/4/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit

class BookCommentsViewController: UIViewController {
    
    // MARK: - Constants
    
    struct Constants {
        static let estimatedRowHeight: CGFloat = 90
    }
    
    // MARK: - Properties
    
    private lazy var _view: BookComentsTableView = BookComentsTableView.loadFromNib()!
    private let _commentsViewModel: BookCommentsViewModel
    
    // MARK: - Initializers
    
    init(commentsViewModel: BookCommentsViewModel) {
        _commentsViewModel = commentsViewModel
        
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
        bindViewModel(_commentsViewModel)
        _commentsViewModel.getBookComments()
    }
    
    // MARK: - Private methods
    
    private func configureTableView(_ tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = Constants.estimatedRowHeight
        
        tableView.register(cell: BookCommentCell.self)
        tableView.register(cell: EmptyCommentCell.self)
    }
    
    private func bindViewModel(_ viewModel: BookCommentsViewModel) {
        viewModel.comments.producer
            .take(during: self.reactive.lifetime)
            .startWithValues { [unowned self] _ in
                self._view.tableView.reloadData()
        }
        
        viewModel.errors
            .take(during: self.reactive.lifetime)
            .observeValues { [unowned self] (error) in
                showErrorMessage(with: error, in: self)
        }
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource

extension BookCommentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _commentsViewModel.comments.value.isEmpty ? 1 : _commentsViewModel.comments.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !_commentsViewModel.comments.value.isEmpty else {
            let cell = _view.tableView.dequeue(cell: EmptyCommentCell.self)!
            return cell
        }
        
        let cell = _view.tableView.dequeue(cell: BookCommentCell.self)!
        cell.configureCell(with: _commentsViewModel.comments.value[indexPath.row])
        return cell
    }
}
