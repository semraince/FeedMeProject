//
//  RestaurantHeaderPresenter.swift.swift
//  yemeksepeti
//
//  Created by semra on 17.08.2021.
//

import Foundation

protocol RestaurantHeaderPresenterInterface {
    var imageUrl: URL? { get }
    var speed: String { get }
    var score: String { get }
    var category: String { get }
    var name: String { get }
    var deliveryTime: String { get }

    func load()
}

final class RestaurantHeaderPresenter {
    private weak var view: RestaurantHeaderViewInterface!
    private let item: RestaurantDetailResponse
    
    init(view: RestaurantHeaderViewInterface, item: RestaurantDetailResponse) {
        self.view = view
        self.item = item
    }
}

extension RestaurantHeaderPresenter: RestaurantHeaderPresenterInterface {
    func load() {
        view.prepareUI()
        view.configure()
    }

    var imageUrl: URL? {
        let fullPath = "\(item.imageID)".imageUrlPath
        if let url = URL(string: fullPath) {
            return url;
        }
        return nil
    }

    var name: String {
        item.name 
    }

    var category: String {
        item.categoryName
    }

    var speed: String {
        String(item.speed) + " hız"
    }
    
    var deliveryTime: String {
        item.deliveryTime 
    }
    
    var score: String {
        String(item.averageScore)
    }
}
