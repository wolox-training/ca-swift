//
//  AddNewViewController.swift
//  WBooks
//
//  Created by Carolina Arcos on 9/6/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit
import ReactiveSwift
import MobileCoreServices

class AddNewViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var _view: AddNewView = AddNewView.loadFromNib()!
    private lazy var _mediaPicker =  MediaPickerService(viewController: self)
    private let _addNewViewModel: AddNewViewModel

    // MARK: - Initializers
    
    init(addNewViewModel: AddNewViewModel) {
        _addNewViewModel = addNewViewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = _view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindImagePicker()

        addHeaderImage(to: self.view)
    }
    
    // MARK: - Private methods
    
    private func bindImagePicker() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        _view.coverImageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func selectImage() {
        _mediaPicker.presentImagePickerController(from: .photoLibrary, for: [.image]) {
            print("permisionNotGranted")
        }
        
        _mediaPicker.mediaSignal
            .take(during: self.reactive.lifetime)
            .observeResult { [unowned self] (result) in
                switch result {
                case let .success(media):
                    switch media {
                    case .image(let image):
                        self._view.coverImageView.image = image
                    default:
                        print("**** image Error: not and image")
                    }
                case let .failure(error):
                    print("**** image Error: \(error)")
                }
        }
    }
}
