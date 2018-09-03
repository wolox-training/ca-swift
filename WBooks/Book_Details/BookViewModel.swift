//
//  BookViewModel.swift
//  WBooks
//
//  Created by Carolina Arcos on 9/3/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import ReactiveSwift

class BookViewModel {
    
    // MARK: - Properties
    
    let book: Book!
    
    // MARK: - Initializers
    
    init(book: Book) {
        self.book = book
    }
    
}
