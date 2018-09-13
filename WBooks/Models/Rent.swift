//
//  Rent.swift
//  WBooks
//
//  Created by Carolina Arcos on 9/4/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import Argo
import Runes
import Curry

struct Rent: Equatable {
    
    // MARK: - Properties
    
    let id: Int
    let startDate: String
    let finalDate: String
    let returnedDate: String?
    let book: Book
    let user: User
}

extension Rent: Argo.Decodable {
    public static func decode(_ json: JSON) -> Decoded<Rent> {
        return curry(Rent.init)
        <^> json <| "id"
        <*> json <| "from"
        <*> json <| "to"
        <*> json <|? "returned_at"
        <*> json <| "book"
        <*> json <| "user"
    }
}
