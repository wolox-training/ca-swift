//
//  ImageFetcherMock.swift
//  WBooksTests
//
//  Created by Carolina Arcos on 9/11/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift

@testable import WBooks

let MockImage = Bundle(for: type(of: ImageFetcherMock())).path(forResource: "mockImage", ofType: "jpg").flatMap({ UIImage(contentsOfFile: $0) })!

class ImageFetcherMock: ImageFetcherType {
    var expectedError: Bool = false
    
    func fetchImage(_ imageURL: URL, with session: URLSession) -> SignalProducer<UIImage, ImageFetcherError> {
        if expectedError {
            return SignalProducer(error: ImageFetcherError.invalidImageFormat)
        } else {
            return SignalProducer(value: MockImage)
        }
    }
    
    func fetchImage(_ imageURL: URL) -> SignalProducer<UIImage, ImageFetcherError> {
        return fetchImage(imageURL, with: URLSession.shared)
    }
    
    
}
