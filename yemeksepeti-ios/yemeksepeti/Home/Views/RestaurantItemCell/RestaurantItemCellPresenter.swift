//
//  RestaurantItemCellPresenter.swift
//  yemeksepeti
//
//  Created by semra on 15.08.2021.
//

import Foundation

protocol RestaurantItemCellPresenterInterface {
    var imageUrl: URL? { get }
    var speed: String { get }
    var score: String { get }
    var category: String { get }
    var name: String { get }
    var deliveryTime: String { get }

    func load()
}

final class RestaurantItemCellPresenter {
    private weak var view: RestaurantItemCellInterface!
    private let item: MainResponseItemList
    
    init(view: RestaurantItemCellInterface,
         item: MainResponseItemList) {
        self.view = view
        self.item = item
    }
}

extension RestaurantItemCellPresenter: RestaurantItemCellPresenterInterface {
    func load(){
        view.prepareUI()
        view.configure()
    }

    var imageUrl: URL? {
        if let imageID = item.imageID {
            let fullPath = "\(imageID)".imageUrlPath
            if let url = URL(string: fullPath) {
                return url;
            }
        }
        return nil
    }

    var name: String{
        item.name ?? ""
    }
    var category: String {
        item.categoryName ?? "";
    }
    var speed: String {
        if let speed = item.speed {
            return String(speed) + " hız"
        }
        return "";
    }
    
    var deliveryTime: String {
        item.deliveryTime ?? ""
    }
    
    var score: String {
        if let averageScore = item.averageScore {
            return String(averageScore)
        }
        return "";
    }
}
