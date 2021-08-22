//
//  CategoryItemCellPresenter.swift
//  yemeksepeti
//
//  Created by semra on 15.08.2021.
//

import Foundation

protocol CategoryItemCellPresenterInterface {
    var imageUrl: URL? { get }
    var name: String { get }
    
    func load()
}

final class CategoryItemCellPresenter {
    private weak var view: CategoryItemCellInterface!
    private let item: HomeResponseItemList
    
    init(view: CategoryItemCellInterface, item: HomeResponseItemList) {
        self.view = view
        self.item = item
    }
}

extension CategoryItemCellPresenter: CategoryItemCellPresenterInterface {
    func load() {
        view?.prepareUI()
        view.configure()
    }
    
    var name: String{
        item.name
    }
    
    var imageUrl: URL? {
        let fullPath = "\(String(describing: item.imageID))".imageUrlPath
        if let url = URL(string: fullPath) {
            return url
        }
        return nil
    }
}
