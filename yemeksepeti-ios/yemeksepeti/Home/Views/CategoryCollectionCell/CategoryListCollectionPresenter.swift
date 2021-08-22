//
//  CategoryListPresenter.swift
//  yemeksepeti
//
//  Created by semra on 15.08.2021.
//

import Foundation

protocol CategoryListCollectionPresenterInterface {
    var numberOfItems: Int { get }
    
    func categoryItem(indexPath: Int) -> HomeResponseItemList?
    func load()
    func didSelectRowAt(index: Int)
}

final class CategoryListCollectionPresenter {
    private weak var view: CategoryListCollectionViewCellInterface!
    private let categoryList: [HomeResponseItemList]
    private let homeDelegate: HomeCategoryDelegate
    
    init(view: CategoryListCollectionViewCellInterface, list:[HomeResponseItemList], delegate: HomeCategoryDelegate) {
        self.view = view
        self.categoryList = list
        self.homeDelegate = delegate
    }
}

extension CategoryListCollectionPresenter: CategoryListCollectionPresenterInterface {
    var numberOfItems: Int {
        categoryList.count
    }

    func categoryItem(indexPath: Int) -> HomeResponseItemList? {
        categoryList[safe: indexPath]
    }
    
    func load() {
        view.configure()
    }

    func didSelectRowAt(index: Int){
        guard let item = categoryList[safe: index] else { return }
        print(item.name)
        homeDelegate.navigateCategory(by: item.id)
        //router.navigateRestaurants();
    }
}
