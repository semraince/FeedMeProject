//
//  RestaurantHomePresenter.swift
//  yemeksepeti
//
//  Created by semra on 14.08.2021.
//

import Foundation

protocol RestaurantHomePresenterInterface: BasePresenterInterface {
    
}

final class RestaurantHomePresenter: RestaurantHomePresenterInterface {
    private weak var view: RestaurantHomeViewControllerInterface!
    
    init(view: RestaurantHomeViewControllerInterface) {
        self.view = view
    }
    
}
