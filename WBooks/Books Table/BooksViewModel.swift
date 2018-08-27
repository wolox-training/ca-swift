//
//  BooksViewModel.swift
//  WBooks
//
//  Created by Carolina Arcos on 8/24/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import ReactiveCocoa
import ReactiveSwift
import Result

class BooksViewModel {
    
    // MARK: - Properties
//    var books = [Book]()
    let mutableBooks = MutableProperty([Book]())
    let getBooks: () -> SignalProducer<[Book], NSError>
    
    init(getBooks: @escaping () -> SignalProducer<[Book], NSError>) {
        self.getBooks = getBooks
        loadBooks()
    }
    
    func loadBooks() {
        let signal = Signal<[Book], NSError>.Observer(
            value: { array in
//                self.books = array
                self.mutableBooks.value = array
        },
            failed: { (error) in
                print("Error \(error)")
        })

        self.getBooks().start(signal)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.mutableBooks.value = [Book(id: 0, author: "Some", title: "Some title", imageUrl: "image"),
            Book(id: 0, author: "another", title: "another title", imageUrl: "image")]
        }
    }
}
