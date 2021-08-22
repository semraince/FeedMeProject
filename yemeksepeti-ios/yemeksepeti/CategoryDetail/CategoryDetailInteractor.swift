//
//  CategoryDetailInteractor.swift
//  yemeksepeti
//
//  Created by semra on 17.08.2021.
//

import Foundation
import NetworkAPI

protocol CategoryDetailInteractorInterface {
    // AddressListPresenter -> AddressListInteractor
    func fetchCategoryDetail(by id:Int, page: Int)
}

protocol CategoryDetailInteractorOutput {
    func handleCategoryResult(_ result: HomeResult)
}

final class CategoryDetailInteractor {
    weak var presenter: CategoryDetailPresenterInterface?
    var output: CategoryDetailInteractorOutput?
}

extension CategoryDetailInteractor: CategoryDetailInteractorInterface {
    func fetchCategoryDetail(by id:Int, page: Int) {
        APIClient.shared.request(responseType: HomeResponse.self, router: CategoryDetailEndpointItem.detail(id: id, page: page, userId: nil)) { [weak self] result in
            print(result)
            self?.output?.handleCategoryResult(result)
        }
    }
}
