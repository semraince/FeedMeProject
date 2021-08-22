//
//  RestaurantDetailInteractor.swift
//  yemeksepeti
//
//  Created by semra on 14.08.2021.
//

import Foundation
import NetworkAPI

// MARK: - RestaurantDetailResponse
struct RestaurantDetailResponse: Decodable {
    let type, name: String
    let imageID, id: Int
    let speed: Double
    let categoryName: String
    let averageScore, service, taste: Double
    let deliveryTime: String
    let productTypeList: [ProductTypeList]
}

// MARK: - ProductTypeList
struct ProductTypeList: Decodable {
    let productCategoryId: Int
    let productCategoryName: String
    let productList: [ProductList]
}

// MARK: - ProductList
struct ProductList: Codable {
    let productId: Int
    let name: String
    let price: Double
    let productImageID: Int
    let ingredients: String?
}

typealias RestaurantDetailResult = APIResponse<RestaurantDetailResponse>

struct BasketResponse: Decodable {
    let message: String?
    let errorCode: Int?
    let totalPrice: Double?
    let restaurantResponse: RestaurantResponse?
    let orderItemDtoList: [OrderItemDtoList]?
}

// MARK: - OrderItemDtoList
struct OrderItemDtoList: Decodable {
    let productId: Int
    let name: String
    let totalPrice: Double
    let count: Int
    let imageId: Int
}

typealias BasketResult = APIResponse<BasketResponse>
// MARK: - RestaurantResponse
struct RestaurantResponse: Decodable {
    let type, name: String
    let imageID, id: Int
    let speed: Double
    let categoryName: String
    let averageScore, service, taste: Double
    let deliveryTime: String
}

protocol RestaurantDetailInteractorInterface {
    func fetchRestaurantDetail(by id:Int)
    func addToBasket(with productId: Int)
    func removeFromBasket(with productId: Int)
}

protocol RestaurantDetailInteractorOutput {
    func handleDetailResult(_ result: RestaurantDetailResult)
}

final class RestaurantDetailInteractor {
    weak var presenter: RestaurantDetailPresenterInterface?
    var output: RestaurantDetailInteractorOutput?
}

extension RestaurantDetailInteractor: RestaurantDetailInteractorInterface {
    func fetchRestaurantDetail(by id:Int) {
        APIClient.shared.request(responseType: RestaurantDetailResponse.self, router: RestaurantDetailEndpointItem.detail(id: id, userId: nil)) { [weak self] result in
            print(result)
            self?.output?.handleDetailResult(result)
        }
    }
    
    func addToBasket(with productId: Int){
        APIClient.shared.request(responseType: BasketResponse.self, router: RestaurantDetailEndpointItem.addToBasket(userId: 1, productId: productId, count: 1)) { [weak self] result in
            print(result)
        }
    }
    
    func removeFromBasket(with productId: Int) {
        APIClient.shared.request(responseType: BasketResponse.self, router: RestaurantDetailEndpointItem.removeFromBasket(userId: 1, productId: productId)) { [weak self] result in
            print(result)
        }
    }
}
