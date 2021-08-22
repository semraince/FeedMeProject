//
//  Task.swift
//  yemeksepeti
//
//  Created by semra on 14.08.2021.
//

import Foundation

public typealias Parameters = [String: Any]

public enum Task {
    case plain
    case parameters(Parameters)
}
