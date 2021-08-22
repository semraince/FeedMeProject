//
//  BasePresenterInterface.swift
//  yemeksepeti
//
//  Created by semra on 14.08.2021.
//

import Foundation

protocol BasePresenterInterface: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisseappear()
}

extension BasePresenterInterface {
    func viewDidLoad() { }
    func viewWillAppear() { }
    func viewWillDisseappear() {}
}
