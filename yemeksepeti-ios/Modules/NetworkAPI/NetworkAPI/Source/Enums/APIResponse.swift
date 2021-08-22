//
//  Response.swift
//  yemeksepeti
//
//  Created by semra on 14.08.2021.
//

import Foundation

public enum APIResponse<T: Decodable> {
    case success(T)
    case failure(APIError)
}
