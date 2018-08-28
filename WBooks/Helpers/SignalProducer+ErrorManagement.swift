//
//  SignalProducer+ErrorManagement.swift
//  WBooks
//
//  Created by Carolina Arcos on 8/28/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import ReactiveSwift

extension SignalProducer {
    
    func liftError<NewError: Swift.Error>() -> SignalProducer<Value, NewError> {
        return flatMapError { _ in SignalProducer<Value, NewError>.empty }
    }
}
