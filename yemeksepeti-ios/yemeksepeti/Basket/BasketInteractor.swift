//
//  BasketInteractor.swift
//  yemeksepeti
//
//  Created by semra on 21.08.2021.
//

import Foundation
import NetworkAPI

protocol BasketInteractorInterface {
    func fetchBasket()
    func addItem(with id: Int)
    func removeItem(with id: Int)
    func createOrder()
    
}


protocol BasketInteractorOutput {
    func handleBasketResult(_ result: BasketResult)
    func orderCreated(_ result: BasketResult)
}

final class BasketInteractor {
    weak var presenter: BasketPresenterInterface?
    var output: BasketInteractorOutput?
}

extension BasketInteractor: BasketInteractorInterface {
    func fetchBasket() {
        APIClient.shared.request(responseType: BasketResponse.self, router: BasketEndpointItem.basket(userId: 1)) { [weak self] result in
            print(result)
            self?.output?.handleBasketResult(result)
        }
    }
    func addItem(with id: Int) {
        APIClient.shared.request(responseType: BasketResponse.self, router: BasketEndpointItem.addToBasket(userId: 1, productId: id, count: 1)) { [weak self] result in
            print(result)
            self?.output?.handleBasketResult(result)
        }
    }
    
    func removeItem(with id: Int){
        APIClient.shared.request(responseType: BasketResponse.self, router: BasketEndpointItem.removeFromBasket(userId: 1, productId: id)) { [weak self] result in
            print(result)
            self?.output?.handleBasketResult(result)
        }
    }
    func createOrder(){
        APIClient.shared.request(responseType: BasketResponse.self, router: BasketEndpointItem.order(userId: 1)){ [weak self] result in
            print(result)
            self?.output?.orderCreated(result)
        }
    }
}

