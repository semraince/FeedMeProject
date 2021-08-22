//
//  LoadingShowable.swift
//  yemeksepeti
//
//  Created by semra on 17.08.2021.
//
import UIKit

protocol LoadingShowable: AnyObject {
    func showLoading()
    func hideLoading()
}

extension LoadingShowable {
    func showLoading() {
        LoadingView.shared.startLoading()
    }

    func hideLoading() {
        LoadingView.shared.hideLoading()
    }
}
