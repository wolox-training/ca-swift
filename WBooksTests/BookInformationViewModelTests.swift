//
//  BookInformationViewModelTests.swift
//  WBooksTests
//
//  Created by Carolina Arcos on 9/11/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Result
import Networking

@testable import WBooks

class BookInformationViewModelTests: QuickSpec {
    override func spec() {
        var repository: UserBooksRepositoryMock!
        var viewModel: BookInformationViewModel!
        var book: Book!
        var imageFetcher: ImageFetcherMock!
        
        describe("#updateBookInfo") {
            
            beforeEach {
                repository = UserBooksRepositoryMock()
                book = DefaultBook
                imageFetcher = ImageFetcherMock()
            }
            
            context("when image can't be fetched") {
                beforeEach {
                    imageFetcher.expectedError = true
                    viewModel = BookInformationViewModel(book: book, userBooksRepository: repository, imageFetcher: imageFetcher)
                }
                
                it("shouldn't update #image") { waitUntil { done in
                    viewModel.updateBookInfo()
                    viewModel.image.producer.startWithValues({ (image) in
                    expect(image).to(equal(GeneralConstants.Design.appDefaultImage))
                        done()
                    })
                    }
                }
            }
            
            context("when image is fetched") {
                beforeEach {
                    viewModel = BookInformationViewModel(book: book, userBooksRepository: repository, imageFetcher: imageFetcher)
                }
                
//                it("should update #image") { waitUntil { done in
//                    viewModel.updateBookInfo()
//                    viewModel.image.producer.skip(first: 1).startWithValues({ (image) in
//                        expect(image).to(equal(MockImage))
//                        done()
//                    })
//                    }
//            }
            }
            
            context("when the status can't be gotten") {
                beforeEach {
                    repository._booksRepositoryMock.expectedError = true
                    viewModel = BookInformationViewModel(book: book, userBooksRepository: repository, imageFetcher: imageFetcher)
                }
                
                it("shouldn't update #bookStatus") { waitUntil { done in
                    viewModel.updateBookInfo()
                    viewModel.bookStatus.producer.startWithValues({ (status) in
                        expect(status).to(equal(BookStatus.notAvailable))
                        done()
                    })
                    }
                }
            }
            
            context("when an available status is gotten") {
                beforeEach {
                    viewModel = BookInformationViewModel(book: book, userBooksRepository: repository, imageFetcher: imageFetcher)
                }
                
                it("should update #bookStatus") { waitUntil { done in
                    viewModel.updateBookInfo()
                    viewModel.bookStatus.producer.startWithValues({ (status) in
                        expect(status).to(equal(BookStatus.available))
                        done()
                    })
                    }
                }
            }
        }
        
        describe("#rentBook") {
            
            beforeEach {
                repository = UserBooksRepositoryMock()
                book = DefaultBook
                imageFetcher = ImageFetcherMock()
            }
            
            context("when book is successfully rented") {
                beforeEach {
                    viewModel = BookInformationViewModel(book: book, userBooksRepository: repository, imageFetcher: imageFetcher)
                }
                
//                it("should get a valid Rent") { waitUntil { done in
//                    viewModel.rentBook().startWithResult({ (result) in
//                        expect(result).to(Result.success(Any))
//                    })
//                    }
//                }
            }
            
            context("when book couldn't be rented") {
                beforeEach {
                    viewModel = BookInformationViewModel(book: book, userBooksRepository: repository, imageFetcher: imageFetcher)
                }
                
//                it("should get and error") { waitUntil { done in
//                    viewModel.rentBook().startWithValues({ (result) in
//                        expect(result).to(equal(SuccessfulRent))
//                    })
//                    }
//                }
            }
        }
    }
}
