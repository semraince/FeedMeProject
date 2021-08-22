//
//  BasketEndpointItem.swift
//  yemeksepeti
//
//  Created by semra on 21.08.2021.
//

import NetworkAPI

enum BasketEndpointItem {
    case basket(userId: Int)
    case addToBasket(userId: Int?, productId: Int, count: Int)
    case removeFromBasket(userId: Int, productId: Int)
    case order(userId: Int)
}

extension BasketEndpointItem: Routable {
    var baseURL: URL {
        return URL(fileURLWithPath: "https://restaurantbootcampapp.herokuapp.com")
    }
    
    var path: String {
        switch self {
        case .basket(let userId):
            return "/getBasket/\(userId)"
        case .addToBasket(let userId, let productId, let count):
            if let userId = userId {
                return "/addToBasket/\(userId)/\(productId)/\(count)"
            } else {
                return "/addToBasket/\(productId)/\(count)"
            }
        case .removeFromBasket(let userId, let productId):
            return "/removeFromBasket/\(userId)/\(productId)"
        case .order(let userId):
            return "/createOrder/\(userId)"
        }
        
    }
    
    var method: HTTPMethod {
        switch self {
        case .basket:
            return .get
        case .addToBasket:
            return .post
        case .removeFromBasket:
            return .delete
        case .order:
            return .put
        }
    }
    
    var task: Task {
        switch self {
        case .basket:
            return .plain
        case .addToBasket:
            return .plain
        case .removeFromBasket:
            return .plain
        case .order:
            return .plain
        }
    }
    
    var headers: Headers? {
        return [:]
    }
    
    var parametersEncoding: ParametersEncoding {
        switch self {
        case .basket:
            return .json
        case .addToBasket:
            return .json
        case .removeFromBasket:
            return .json
        case .order:
            return .json
        }
    }
}
