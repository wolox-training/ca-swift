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

@testable import WBooks

class BookInformationViewModelTests: QuickSpec {
    override func spec() {
        describe("#updateBookInfo") {
            var repository: UserBooksRepositoryMock!
            var book: Book!
            var viewModel: BookInformationViewModel!
            var imageFetcher: ImageFetcherMock!
            
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
                    }}
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
//                    }}
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
    }
}
