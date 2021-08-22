//
//  RestaurantDetailPresenter.swift
//  yemeksepeti
//
//  Created by semra on 14.08.2021.
//

import Foundation

protocol RestaurantDetailPresenterInterface: BasePresenterInterface {
    var numberOfSections: Int { get }
    var restaurantDetailItem: RestaurantDetailResponse? { get }

    func sectionForItems(for section: Int) -> Int
    func sectionName(for section: Int) -> String
    func item(for indexPath: IndexPath) -> ProductList?
    func didSelectRow(for indexPath: IndexPath)
}

protocol RestaurantProductDelegate {
    func addToBasket(with id: Int)
    func removeFromBasket(with id:Int)
}

final class RestaurantDetailPresenter{
    private weak var view: RestaurantDetailViewControllerInterface!
    private let interactor: RestaurantDetailInteractorInterface!
    private let restaurantId: Int
    private var restaurantDetail: RestaurantDetailResponse?
    private var router: RestaurantDetailRouterInterface!
    
    init(view: RestaurantDetailViewControllerInterface,
         interactor: RestaurantDetailInteractorInterface,
         router: RestaurantDetailRouterInterface,
         restaurantId: Int) {
        self.view = view
        self.interactor = interactor
        self.restaurantId = restaurantId
        self.router = router
    }
}

extension RestaurantDetailPresenter: RestaurantDetailInteractorOutput {
    func handleDetailResult(_ result: RestaurantDetailResult) {
        view.hideLoadingView()
        switch result {
        case let .success(response):
            restaurantDetail = response
            view.prepareCollectionView()
        case let .failure(error):
            print(error)
        }
    }
}

extension RestaurantDetailPresenter: RestaurantProductDelegate {
    func addToBasket(with id: Int) {
        interactor.addToBasket(with: id)
    }
    
    func removeFromBasket(with id: Int) {
        interactor.removeFromBasket(with: id)
    }
}

extension RestaurantDetailPresenter: RestaurantDetailPresenterInterface {
    var numberOfSections: Int {
        restaurantDetail?.productTypeList.count ?? 0
    }

    var restaurantDetailItem: RestaurantDetailResponse? {
        restaurantDetail
    }

    func sectionForItems(for section: Int) -> Int {
        restaurantDetail?.productTypeList[safe: section]?.productList.count ?? 0
    }

    func sectionName(for section: Int) -> String {
        restaurantDetail?.productTypeList[safe: section]?.productCategoryName ?? ""
    }

    func item(for indexPath: IndexPath) -> ProductList? {
        restaurantDetail?.productTypeList[safe: indexPath.section]?.productList[safe: indexPath.row]
    }
    
    func didSelectRow(for index: IndexPath){
        if let item = item(for: index) {
            router?.navigateProductDetail(with: item)
        }
    }

    func viewDidLoad() {
        view.showLoadingView()
        interactor.fetchRestaurantDetail(by: restaurantId)
    }

    func viewWillAppear() {
        view.setNavigationView()
    }
}
