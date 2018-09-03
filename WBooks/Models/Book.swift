//
//  Book.swift
//  WBooks 
//
//  Created by Carolina Arcos on 8/24/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import Argo
import Runes
import Curry

struct Book {
    
    // MARK: - Properties
    
    let id: Int
    let author: String
    let title: String
    let imageUrl: URL?
}

extension Book: Argo.Decodable {
    public static func decode(_ json: JSON) -> Decoded<Book> {
        return curry(Book.init)
        <^> json <| "id"
        <*> json <| "author"
        <*> json <| "title"
        <*> ( (json <|? "image_url") >>- toURL)
    }
}

fileprivate func toURL(urlString: String?) -> Decoded<URL?> {
    return Decoded<URL?>.fromOptional(URL(string: urlString ?? ""))
}
