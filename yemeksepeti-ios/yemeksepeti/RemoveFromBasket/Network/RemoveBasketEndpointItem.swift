//
//  RemoveBasketEndpointItem.swift
//  yemeksepeti
//
//  Created by semra on 20.08.2021.
//

import NetworkAPI

enum RemoveBasketEndpointItem {
    case remove(userId: Int, productId: Int)
}

extension RemoveBasketEndpointItem: Routable {
    var baseURL: URL {
        return URL(fileURLWithPath: "https://restaurantbootcampapp.herokuapp.com")
    }
    
    var path: String {
        switch self {
        case .remove(let userId, let productId):
            return "/removeFromBasket/\(userId)/\(productId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .remove:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .remove:
            return .plain
        }
    }
    
    var headers: Headers? {
        return [:]
    }
    
    var parametersEncoding: ParametersEncoding {
        switch self {
        case .remove:
            return .json
        }
    }
}
