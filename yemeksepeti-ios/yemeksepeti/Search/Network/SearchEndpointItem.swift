//
//  SearchEndpointItem.swift
//  yemeksepeti
//
//  Created by semra on 17.08.2021.
//

import NetworkAPI

enum SearchEndpointItem {
    case result(text: String.UTF8View, page: Int, userId: Int?)
}

extension SearchEndpointItem: Routable {
    var baseURL: URL {
        return URL(fileURLWithPath: "https://restaurantbootcampapp.herokuapp.com")
    }
    
    var path: String {
        switch self {
        case .result(let text, let page, let userId):
            if let userId = userId {
                return "/search/\(text)/\(page)/\(userId)"
            } else {
                return "/search/\(text)/\(page)"
            }
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .result:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .result:
            return .plain
        }
    }
    
    var headers: Headers? {
        return [:]
    }
    
    var parametersEncoding: ParametersEncoding {
        switch self {
        case .result:
            return .json
        }
    }
}
