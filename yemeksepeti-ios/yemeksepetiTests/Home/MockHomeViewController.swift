//
//  MockHomeViewController.swift
//  yemeksepetiTests
//
//  Created by semra on 22.08.2021.
//

@testable import yemeksepeti
import XCTest

final class MockHomeViewController: HomeViewControllerInterface {
    var invokedConfigure = false
    var invokedConfigureCount = 0

    func configure() {
        invokedConfigure = true
        invokedConfigureCount += 1
    }

    var invokedRefresh = false
    var invokedRefreshCount = 0

    func refresh() {
        invokedRefresh = true
        invokedRefreshCount += 1
    }

    var invokedSetNavigationBarView = false
    var invokedSetNavigationBarViewCount = 0

    func setNavigationBarView() {
        invokedSetNavigationBarView = true
        invokedSetNavigationBarViewCount += 1
    }

    var invokedPrepareNavigationBarViewWithTitle = false
    var invokedPrepareNavigationBarViewWithTitleCount = 0
    var invokedPrepareNavigationBarViewWithTitleParameters: (title: String, Void)?
    var invokedPrepareNavigationBarViewWithTitleParametersList = [(title: String, Void)]()

    func prepareNavigationBarViewWithTitle(_ title: String) {
        invokedPrepareNavigationBarViewWithTitle = true
        invokedPrepareNavigationBarViewWithTitleCount += 1
        invokedPrepareNavigationBarViewWithTitleParameters = (title, ())
        invokedPrepareNavigationBarViewWithTitleParametersList.append((title, ()))
    }

    var invokedPrepareNavigationBarView = false
    var invokedPrepareNavigationBarViewCount = 0

    func prepareNavigationBarView() {
        invokedPrepareNavigationBarView = true
        invokedPrepareNavigationBarViewCount += 1
    }

    var invokedShowLoadingView = false
    var invokedShowLoadingViewCount = 0

    func showLoadingView() {
        invokedShowLoadingView = true
        invokedShowLoadingViewCount += 1
    }

    var invokedHideLoadingView = false
    var invokedHideLoadingViewCount = 0

    func hideLoadingView() {
        invokedHideLoadingView = true
        invokedHideLoadingViewCount += 1
    }

    var invokedShowLoading = false
    var invokedShowLoadingCount = 0

    func showLoading() {
        invokedShowLoading = true
        invokedShowLoadingCount += 1
    }

    var invokedHideLoading = false
    var invokedHideLoadingCount = 0

    func hideLoading() {
        invokedHideLoading = true
        invokedHideLoadingCount += 1
    }
}
