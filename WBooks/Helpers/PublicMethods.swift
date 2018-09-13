//
//  PublicMethods.swift
//  WBooks
//
//  Created by Carolina Arcos on 9/5/18.
//  Copyright © 2018 Wolox. All rights reserved.
//

import UIKit
import Networking

func addHeaderImage(to view: UIView) {
    let headerImage = UIImageView(image: GeneralConstants.Design.navigationBarImage)
    headerImage.contentMode = .bottom
    headerImage.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(headerImage)
    
    NSLayoutConstraint.activate([headerImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                 headerImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                 headerImage.topAnchor.constraint(equalTo: view.topAnchor),
                                 headerImage.heightAnchor.constraint(equalToConstant: GeneralConstants.Design.headerImageHeight)
        ])
}

func showErrorMessage(with error: Error, in viewController: UIViewController) {
    let alertError = UIAlertController(title: GeneralConstants.Texts.errorAlertTitle,
                                       message: error.localizedDescription,
                                       preferredStyle: .alert)
    alertError.addAction(UIAlertAction(title: GeneralConstants.Texts.errorAlertButtonTitle,
                                       style: .default,
                                       handler: nil))
    viewController.present(alertError, animated: true, completion: nil)
}

func showMessage(_ text: String, in viewController: UIViewController) {
    let alert = UIAlertController(title: "", message: text, preferredStyle: .alert)
    viewController.present(alert, animated: true, completion: nil)
    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
    
}
