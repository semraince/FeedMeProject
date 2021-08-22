//
//  UserEndPointItem.swift
//  yemeksepeti
//
//  Created by semra on 20.08.2021.
//

import NetworkAPI

enum UserEndpointItem {
    case login(userId: String)
    case createUser(email: String, userId: String)
}

extension UserEndpointItem: Routable {
    var baseURL: URL {
        return URL(fileURLWithPath: "https://restaurantbootcampapp.herokuapp.com")
    }
    
    var path: String {
        switch self {
        case .login(let userId):
            return "/getUser/\(userId)"
        case .createUser(let email, let userId):
            return "/createUser"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login:
            return .get
        case .createUser:
            return .post
        }
        
            
    }
    
    var task: Task {
        switch self {
        case .login:
            return .plain
        case .createUser(let email, let userId):
            return .parameters(["email": email, "userId": userId])
            
        }
    }
    
    var headers: Headers? {
        return ["Content-Type": "application/json"]
    }
    
    var parametersEncoding: ParametersEncoding {
        switch self {
        case .login:
            return .json
        case .createUser:
            return .json
        }
    }
}
