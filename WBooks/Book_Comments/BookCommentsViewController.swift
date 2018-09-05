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
    
    // MARK: - Initializers
    
    init() {
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
    }
    
    // MARK: - Private methods
    
    private func configureTableView(_ tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = Constants.estimatedRowHeight
        
        tableView.register(cell: BookCommentCell.self)
    }
}

extension BookCommentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = _view.tableView.dequeue(cell: BookCommentCell.self)!
        
        cell.configureCell()
        
        return cell
    }
}
