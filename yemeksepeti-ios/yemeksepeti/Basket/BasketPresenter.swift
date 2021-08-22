//
//  BasketPresenter.swift
//  yemeksepeti
//
//  Created by semra on 21.08.2021.
//

import Foundation

protocol BasketPresenterInterface: BasePresenterInterface {
    var numberOfItems: Int { get }
    var sectionHeight: Double { get }
    var totalPrice: String { get }
    var isTabBarVisible: Bool { get}

    var restaurantDetail: RestaurantResponse? { get }
    func item(index: Int) -> OrderItemDtoList?
    func createOrder();
}

final class BasketPresenter {
    private weak var view: BasketViewControllerInterface!
    private let interactor: BasketInteractorInterface!
    private var basketResponse: BasketResponse?
    private let router: BasketRouterInterface!
    
    init(view: BasketViewControllerInterface,
         interactor: BasketInteractorInterface,
         router: BasketRouterInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension BasketPresenter: BasketPresenterInterface {
    var totalPrice: String {
        if let totalPrice = basketResponse?.totalPrice{
            return "\(totalPrice) TL"
        }
        return "0.0 TL"
    }
    
    var numberOfItems: Int {
        basketResponse?.orderItemDtoList?.count ?? 0
    }
    
    var sectionHeight: Double {
        basketResponse?.orderItemDtoList?.count ?? 0 > 0 ? 100 : 0
    }

    var isTabBarVisible: Bool {
        basketResponse?.orderItemDtoList?.count ?? 0 > 0 ?  true : false
    }

    var restaurantDetail: RestaurantResponse? {
        basketResponse?.restaurantResponse
    }
    
    func item(index: Int) -> OrderItemDtoList? {
        basketResponse?.orderItemDtoList?[safe: index]
    }
    
    func viewWillAppear() {
        interactor.fetchBasket()
    }

    func createOrder() {
        interactor.createOrder()
    }
}

extension BasketPresenter: BasketPresenterDelegate {
    func addItem(with id: Int) {
        interactor.addItem(with: id)
    }
    
    func removeItem(with id: Int){
        interactor.removeItem(with: id)
    }
}

extension BasketPresenter: BasketInteractorOutput {
    func handleBasketResult(_ result: BasketResult) {
        switch result {
        case .success(let response):
            basketResponse = response
            isTabBarVisible ? view.showBottomView() : view.hideBottomView()
            if(basketResponse == nil || basketResponse?.orderItemDtoList == nil || basketResponse?.orderItemDtoList?.count == 0) {
                view.reloadData()
                view.setEmptyView();
            }
            else {
                view.configure()
                view.reloadData()
            }
        case .failure(let error):
            print(error)
        }
    }
    
    func orderCreated(_ result: BasketResult) {
        switch result {
        case .success(let response):
            basketResponse = response
            AlertView.instance.showAlert(title: "Başarılı",
                                         message: "Siparişiniz başarıyla oluşturuldu.",
                                         alertType: .success,
                                         alertedItem: self)
        case .failure(let error):
            print(error)
        }
    }
}

extension BasketPresenter: AlertViewProtocol{
    func alertButtonClicked() {
        basketResponse = nil
        view.reloadData()
        isTabBarVisible ? view.showBottomView() : view.hideBottomView()
        view.setEmptyView()
    }
}
