//
//  HomeEndpointItem.swift
//  yemeksepeti
//
//  Created by semra on 14.08.2021.
//

import NetworkAPI

enum HomeEndpointItem {
    case home(page: Int, userId: Int?)
}

extension HomeEndpointItem: Routable {
    var baseURL: URL {
        return URL(fileURLWithPath: "https://restaurantbootcampapp.herokuapp.com")
    }
    
    var path: String {
        switch self {
        case .home(let page, let userId):
            if let userId = userId {
                return "/homeRequest/\(page)/\(userId)"
            } else {
                return "/homeRequest/\(page)"
            }
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .home:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .home:
            return .plain
        }
    }
    
    var headers: Headers? {
        return [:]
    }
    
    var parametersEncoding: ParametersEncoding {
        switch self {
        case .home:
            return .json
        }
    }
}
