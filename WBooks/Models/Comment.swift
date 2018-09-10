//
//  Comment.swift
//  WBooks
//
//  Created by Carolina Arcos on 9/5/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import Argo
import Runes
import Curry

struct Comment {
    let id: Int
    let comment: String
    let user: User
}

extension Comment: Argo.Decodable {
    public static func decode(_ json: JSON) -> Decoded<Comment> {
        return curry(Comment.init)
        <^> json <| "id"
        <*> json <| "content"
        <*> json <| "user"
    }
}
