//
//  RestaurantHomeInteractor.swift
//  yemeksepeti
//
//  Created by semra on 14.08.2021.
//
import Foundation
import NetworkAPI

struct RestaurantHomeResponse: Decodable {
    
}
protocol RestaurantHomeInteractorInterface {
    // AddressListPresenter -> AddressListInteractor
    func fetchAddressList()
}

final class RestaurantHomeInteractor {
    weak var presenter: RestaurantHomePresenterInterface?
}

extension RestaurantHomeInteractor: RestaurantHomeInteractorInterface {
    func fetchAddressList() {
        APIClient.shared.request(responseType: RestaurantHomeResponse.self, router: HomeEndpointItem.home(page: 0, userId: nil)) { result in
        }
    }
}


