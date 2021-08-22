//
//  RestaurantDetailEndpointItem.swift
//  yemeksepeti
//
//  Created by semra on 17.08.2021.
//

import NetworkAPI

enum CategoryDetailEndpointItem {
    case detail(id: Int, page: Int, userId: Int?)
}

extension CategoryDetailEndpointItem: Routable {
    var baseURL: URL {
        return URL(fileURLWithPath: "https://restaurantbootcampapp.herokuapp.com")
    }
    
    var path: String {
        switch self {
        case .detail(let id, let page, let userId):
            if let userId = userId {
                return "/getCategory/\(id)/\(page)/\(userId)"
            } else {
                return "/getCategory/\(id)/\(page)"
            }
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .detail:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .detail:
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
        }
    }
}
