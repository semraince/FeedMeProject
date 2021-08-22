//
//  URLComponents+API.swift
//  yemeksepeti
//
//  Created by semra on 14.08.2021.
//

import Foundation

public extension URLComponents {
    init(router: Routable) {
        let url = router.baseURL.appendingPathComponent(router.path)
        self.init(url: url, resolvingAgainstBaseURL: false)!
        guard case let .parameters(parameters) = router.task,
              router.parametersEncoding == .url else { return }
        queryItems = parameters.map { key, value in
            return URLQueryItem(name: key, value: String(describing: value))
        }
    }
}
