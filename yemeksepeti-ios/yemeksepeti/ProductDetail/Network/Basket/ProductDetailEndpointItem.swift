//
//  ProductDetailEndpointItem.swift
//  yemeksepeti
//
//  Created by semra on 22.08.2021.
//

import Foundation
import NetworkAPI

enum ProductDetailEndpointItem {
    case removeBasket(userId: Int)
}

extension ProductDetailEndpointItem: Routable {
    var baseURL: URL {
        return URL(fileURLWithPath: "https://restaurantbootcampapp.herokuapp.com")
    }
    
    var path: String {
        switch self {
        case .removeBasket(let userId):
            return "/removeBasket/\(userId)"
        }
        
    }
    
    var method: HTTPMethod {
        switch self {
        case .removeBasket:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .removeBasket:
            return .plain
        }
    }
    
    var headers: Headers? {
        return [:]
    }
    
    var parametersEncoding: ParametersEncoding {
        switch self {
        case .removeBasket:
            return .json
        }
    }
}

