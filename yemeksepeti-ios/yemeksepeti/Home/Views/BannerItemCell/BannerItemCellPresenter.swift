//
//  BannerItemCellPresenter.swift
//  yemeksepeti
//
//  Created by semra on 16.08.2021.
//

import Foundation
protocol BannerItemCellPresenterInterface {
    var imageUrl: URL? { get }
    var name: String { get }
    func load()
}

final class BannerItemCellPresenter {
    private weak var view: BannerItemCellInterface!
    private let item: HomeResponseItemList
    
    init(view: BannerItemCellInterface, item: HomeResponseItemList) {
        self.view = view
        self.item = item
    }
}

extension BannerItemCellPresenter: BannerItemCellPresenterInterface{
    var name: String{
        item.name
    }
    var imageUrl: URL? {
        let fullPath = "\(String(describing: item.imageID))".imageUrlPath
        if let url = URL(string: fullPath) {
            return url;
        }
        return nil
    }

    func load(){
        view.configure();
    }
}
