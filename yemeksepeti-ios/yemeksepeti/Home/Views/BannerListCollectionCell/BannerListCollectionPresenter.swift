//
//  BannerItemListPresenter.swift
//  yemeksepeti
//
//  Created by semra on 14.08.2021.
//

import Foundation

protocol BannerListCollectionPresenterInterface {
    var numberOfItems: Int { get }
    func bannerItem(indexPath: Int) -> HomeResponseItemList?
    func load()
}

final class BannerListCollectionPresenter {
    private weak var view: BannerListCollectionViewCellInterface!
    private let bannerList: [HomeResponseItemList]
    
    init(view: BannerListCollectionViewCellInterface, list: [HomeResponseItemList]) {
        self.view = view
        self.bannerList = list
    }
}

extension BannerListCollectionPresenter: BannerListCollectionPresenterInterface {
    var numberOfItems: Int {
        bannerList.count
    }

    func bannerItem(indexPath: Int) -> HomeResponseItemList? {
        bannerList[safe: indexPath]
    }
    
    func load() {
        view.configure()
    }
}
