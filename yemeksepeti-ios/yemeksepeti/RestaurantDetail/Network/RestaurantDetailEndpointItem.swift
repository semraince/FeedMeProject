//
//  RestaurantDetailEndpointItem.swift
//  yemeksepeti
//
//  Created by semra on 17.08.2021.
//

import NetworkAPI

enum RestaurantDetailEndpointItem {
    case detail(id: Int, userId: Int?)
    case addToBasket(userId: Int?, productId: Int, count: Int)
    case removeFromBasket(userId: Int, productId: Int)
}

extension RestaurantDetailEndpointItem: Routable {
    var baseURL: URL {
        return URL(fileURLWithPath: "https://restaurantbootcampapp.herokuapp.com")
    }
    
    var path: String {
        switch self {
        case .detail(let id, let userId):
            if let userId = userId {
                return "/getRestaurant/\(userId)/\(id)"
            } else {
                return "/getRestaurant/\(id)"
            }
        case .addToBasket(let userId, let productId, let count):
            if let userId = userId {
                return "/addToBasket/\(userId)/\(productId)/\(count)"
            } else {
                return "/addToBasket/\(productId)/\(count)"
            }
        case .removeFromBasket(let userId, let productId):
            return "/removeFromBasket/\(userId)/\(productId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .detail:
            return .get
        case .addToBasket:
            return .post
        case .removeFromBasket:
            return .get
        }
        
    }
    
    var task: Task {
        switch self {
        case .detail:
            return .plain
        case .addToBasket:
            return .plain
        case .removeFromBasket:
            return .plain
        }
    }
    
    var headers: Headers? {
        return [:]
    }
    
    var parametersEncoding: ParametersEncoding {
        switch self {
        case .detail:
            return .json
        case .addToBasket:
            return .json
        case .removeFromBasket:
            return .json
        }
    }
}
