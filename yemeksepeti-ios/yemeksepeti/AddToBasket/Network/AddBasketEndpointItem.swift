//
//  AddBasketEndpointItem.swift
//  yemeksepeti
//
//  Created by semra on 20.08.2021.
//

//
//  RemoveBasketEndpointItem.swift
//  yemeksepeti
//
//  Created by semra on 20.08.2021.
//

import Foundation
import NetworkAPI

enum AddBasketEndpointItem {
    case add(userId: Int?, productId: Int, count: Int)
}
extension AddBasketEndpointItem: Routable {
    
    var baseURL: URL {
        return URL(fileURLWithPath: "https://restaurantbootcampapp.herokuapp.com")
    }
    
    var path: String {
        switch self {
        case .add(let userId, let productId, let count):
            if let userId = userId {
                return "/addToBasket/{userId}/{productId}/{count}"
            } else {
                return "/addToBasket/{productId}/{count}"
            }
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .add:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .add:
            return .plain
        }
    }
    
    var headers: Headers? {
        return [:]
    }
    
    var parametersEncoding: ParametersEncoding {
        switch self {
        case .add:
            return .json
        }
    }
}
