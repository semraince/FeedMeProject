//
//  AddToBasketInteractor.swift
//  yemeksepeti
//
//  Created by semra on 20.08.2021.
//

import Foundation

import Foundation
import NetworkAPI




protocol AddBasketInteractorOutput {
    func handleAddBasketResult(_ result: BasketResponse)
}

final class AddBasketInteractor {
   // weak var presenter: AddBasketPresenterInterface?
    var output: AddBasketInteractorOutput?
}
