//
//  ProductListCellPresenter.swift
//  yemeksepeti
//
//  Created by semra on 19.08.2021.
//

import Foundation

protocol ProductListCellPresenterInterface {
    func load()
    func addToBasket()
}

final class ProductListCellPresenter {
    private weak var view: ProductListCollectionViewCellInterface!
    private let item: ProductList
    private let restaurantDelegate: RestaurantProductDelegate?

    init(view: ProductListCollectionViewCellInterface,
         item: ProductList,
         restaurantDelegate: RestaurantProductDelegate?) {
        self.view = view
        self.item = item
        self.restaurantDelegate = restaurantDelegate
    }
}

//MARK: - ProductListCellPresenterInterface
extension ProductListCellPresenter: ProductListCellPresenterInterface {
    func load() {
        view.setTitleLabel(with: item.name)
        if let ingredients = item.ingredients {
            view.setDescriptionLabel(with: ingredients)
        }
        else{
            view.setDescriptionLabel(with: item.name);
        }
    }
    
    func addToBasket() {
        restaurantDelegate?.addToBasket(with: item.productId)
    }
}
