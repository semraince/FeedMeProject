//
//  ProductDetailInteractor.swift
//  yemeksepeti
//
//  Created by semra on 21.08.2021.
//

import Foundation
import NetworkAPI

protocol ProductDetailInteractorOutput {
    func handleBasketResult(_ result: BasketResult)
    func handleEmptyResult(_ result: BasketResult)
}

final class ProductDetailInteractor {
    weak var presenter: ProductDetailPresenterInterface?
    var output: ProductDetailInteractorOutput?
}

protocol ProductDetailInteractorInterface {
    func addToBasket(with productId: Int, count: Int)
    func removeBasket()
}


extension ProductDetailInteractor: ProductDetailInteractorInterface {
    
    func addToBasket(with productId: Int, count: Int){
        APIClient.shared.request(responseType: BasketResponse.self, router: RestaurantDetailEndpointItem.addToBasket(userId: 1, productId: productId, count: count)) { [weak self] result in
            self?.output?.handleBasketResult(result)
        }
    }
        func removeBasket(){
            APIClient.shared.request(responseType: BasketResponse.self, router: ProductDetailEndpointItem.removeBasket(userId: 1)) { [weak self] result in
                self?.output?.handleEmptyResult(result)
            }
        }
}
    
    




