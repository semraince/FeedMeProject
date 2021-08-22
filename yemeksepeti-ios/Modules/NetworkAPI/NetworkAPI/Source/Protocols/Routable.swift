//
//  HTTPMethod.swift
//  yemeksepeti
//
//  Created by semra on 14.08.2021.
//

import Foundation

public typealias Headers = [String: String]

public protocol Routable {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: Task { get }
    var headers: Headers? { get }
    var parametersEncoding: ParametersEncoding { get }
}
