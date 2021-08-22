//
//  UserManager.swift
//  yemeksepeti
//
//  Created by semra on 14.08.2021.
//

import Foundation

public enum APIError {
    case unknown
    case decodingError(Error)
    case noJSONData
    case errorMessage(String)
    case internalServer
}
