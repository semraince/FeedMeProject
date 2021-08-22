//
//  UIViewController+Extension.swift
//  yemeksepeti
//
//  Created semra on 19.08.2021.
//

import UIKit

protocol BaseViewController: LoadingShowable {
    func prepareNavigationBarViewWithTitle(_ title: String)
    func prepareNavigationBarView()
    func showLoadingView()
    func hideLoadingView()
}

extension BaseViewController where Self: UIViewController {
    func prepareNavigationBarViewWithTitle(_ title: String) {
        navigationController?.title = title
        navigationController?.navigationBar.barTintColor = UIColor(red: 171/255, green: 0/255, blue: 18/255, alpha: 1)
    }

    func prepareNavigationBarView() {
        navigationController?.navigationBar.barTintColor = UIColor(red: 171/255, green: 0/255, blue: 18/255, alpha: 1)
        let backButton = UIBarButtonItem()
        navigationController?.navigationItem.title = "HSHSHDH"
        backButton.title = ""
        backButton.tintColor = .white
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    func showLoadingView() {
        showLoading()
    }

    func hideLoadingView() {
        hideLoading()
    }
}
