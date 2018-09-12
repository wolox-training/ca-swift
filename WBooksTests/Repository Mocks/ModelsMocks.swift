//
//  ModelsMocks.swift
//  WBooksTests
//
//  Created by Carolina Arcos on 9/11/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation

@testable import WBooks

let DefaultUser = User(id: 0,
                       firstName: "Jhon",
                       lastName: "Doe",
                       imageURL: "http://imageulr.jpg")

let DefaultBook = Book(id: 0,
                       author: "Hola",
                       title: "Mundo",
                       imageUrl: URL(string: "hppt"),
                       releaseYear: "1234",
                       genre: "Hola")

let SuccessfulRent = Rent(id: 0,
                          startDate: "2018-09-02",
                          finalDate: "2018-10-02",
                          returnedDate: nil,
                          book: DefaultBook,
                          user: DefaultUser)
