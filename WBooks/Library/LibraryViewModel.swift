//
//  LibraryViewModel.swift
//  WBooks
//
//  Created by Carolina Arcos on 8/21/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import ReactiveCocoa

class LibraryViewModel {
    
    // MARK: - Properties
    
    private let _libraryRespository:  BooksRepositoryType
    
    // MARK: - Initializers
    
    public init(libraryRepository: BooksRepositoryType) {
        _libraryRespository = libraryRepository
    }
}
