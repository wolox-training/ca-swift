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
    
    // MARK: - Constants
    
    struct Constants {
        static let defaultCoverImage = UIImage(named: "ic_add photo")!
        static let submitSuccessMessage = "Book information was successfully submitted"
        static let submitFailureMessage = "Book information could not be sent. Try again"
        static let completeInformationMessage = "Complete all information before submitting"
        static let menuGalleryOptionTitle = "Photo Gallery"
        static let menuCameraOptionTitle = "Camera"
        static let menuCancelOptionTitle = "Cancel"
    }
    
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
        
        bindSubmitButton()
        bindImagePicker()

        addHeaderImage(to: self.view)
    }
    
    // MARK: - Private methods
    
    private func bindSubmitButton() {
        self._view.submitButton.reactive.controlEvents(.touchUpInside)
        .take(during: self.reactive.lifetime)
            .observeValues({ [unowned self] _ in
                if self.validateBookInformation() {
                    self._addNewViewModel.submitBook().startWithResult({ [unowned self] (result) in
                        switch result {
                        case .success:
                            showMessage(Constants.submitSuccessMessage, in: self)
                            self.clearInformation()
                        case .failure:
                            showMessage(Constants.submitFailureMessage, in: self)
                        }
                    })
                } else {
                    showMessage(Constants.completeInformationMessage, in: self)
                }
            })
    }
    
    private func bindImagePicker() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        _view.coverImageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func selectImage() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let galleryButton = UIAlertAction(title: Constants.menuGalleryOptionTitle, style: .default, handler: { [unowned self] (action) -> Void in
            self.showPickerController(for: .photoLibrary)
        })
        let cameraButton = UIAlertAction(title: Constants.menuCameraOptionTitle, style: .default, handler: { [unowned self] (action) -> Void in
            self.showPickerController(for: .camera)
        })
        let cancelButton = UIAlertAction(title: Constants.menuCancelOptionTitle, style: .cancel, handler: nil)
    
        actionSheet.addAction(galleryButton)
        actionSheet.addAction(cameraButton)
        actionSheet.addAction(cancelButton)
        
        self.navigationController!.present(actionSheet, animated: true, completion: nil)
    }
    
    private func validateBookInformation() -> Bool {
        guard let _ = Int(_view.yearTextField.text!),
            _view.nameTextField.text!.isNotEmpty,
            _view.authorTextField.text!.isNotEmpty,
            _view.topicTextField.text!.isNotEmpty,
            _view.descriptionTextField.text!.isNotEmpty else {
                return false
        }
        
         return true
    }
    
    private func showPickerController(for type: UIImagePickerControllerSourceType) {
        _mediaPicker.presentImagePickerController(from: type, for: [.image]) {
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
    
    private func clearInformation() {
        _view.nameTextField.text = ""
        _view.authorTextField.text = ""
        _view.yearTextField.text = ""
        _view.topicTextField.text = ""
        _view.descriptionTextField.text = ""
        _view.coverImageView.image = Constants.defaultCoverImage
    }
}
