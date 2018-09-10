//
//  AddNewViewModel.swift
//  WBooks
//
//  Created by Carolina Arcos on 9/6/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation

class AddNewViewModel {
    
    // MARK: - Properties
    
    private let _booksRepository: BooksRepositoryType
    
    // MARK: - Initializers
    
    init(booksRepository: BooksRepositoryType) {
        _booksRepository = booksRepository
    }
    
    // MARK: - Public methods
    
    func submitBook() {
        print("Submitted")
    }
}
