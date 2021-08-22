//
//  MockHomeInteractor.swift
//  yemeksepetiTests
//
//  Created by semra on 22.08.2021.
//

@testable import yemeksepeti
import XCTest

final class MockHomeInteractor: HomeInteractorInterface {
    var invokedFetchAddressList = false
    var invokedFetchAddressListCount = 0
    var invokedFetchAddressListParameters: (page: Int, Void)?
    var invokedFetchAddressListParametersList = [(page: Int, Void)]()

    func fetchAddressList(page: Int) {
        invokedFetchAddressList = true
        invokedFetchAddressListCount += 1
        invokedFetchAddressListParameters = (page, ())
        invokedFetchAddressListParametersList.append((page, ()))
    }
}
