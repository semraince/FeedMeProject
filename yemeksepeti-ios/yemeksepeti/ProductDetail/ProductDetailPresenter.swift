//
//  ProductDetailPresenter.swift
//  yemeksepeti
//
//  Created by semra on 21.08.2021.
//

import Foundation

protocol ProductDetailPresenterInterface: BasePresenterInterface {
    var productName: String { get }
    var productIngredients: String { get }
    var productCount: String { get }
    var imageURL: URL? { get }
    var productPrice: String { get }
    
    func addClicked()
    func removeClicked()
    func doneClicked()
}

final class ProductDetailPresenter {
    private weak var view: ProductDetailViewControllerInterface!
    private let interactor: ProductDetailInteractorInterface!
    private var productDetail: ProductList
    private var basketResponse: BasketResponse!
    private var router: ProductDetailRouterInterface!
    private var count: Int = 1
    
    init(view: ProductDetailViewControllerInterface,
         interactor: ProductDetailInteractorInterface, router: ProductDetailRouterInterface, productDetail: ProductList) {
        self.view = view
        self.interactor = interactor
        self.productDetail = productDetail
        self.router = router
    }
}
extension ProductDetailPresenter: ProductDetailPresenterInterface {
    
    var productName: String {
        productDetail.name
    }
    
    var productIngredients: String {
        if let ingredients = productDetail.ingredients {
            return ingredients
        }
        return productDetail.name
    }
    var productCount: String {
       String(count) + " Adet"
    }
    
    var productPrice: String {
        let price = Double(count) * productDetail.price
        return String(price)
    }
    
    
    var imageURL: URL? {
        let fullPath = "\(String(describing: productDetail.productImageID))".imageUrlPath
        if let url = URL(string: fullPath) {
            return url
        }
        return nil
    }
    
    func viewDidLoad() {
        view.configure()
    }
    
    func addClicked() {
        count += 1
        view.refresh()
    }
    
    func removeClicked() {
        count =  count == 1 ? 1 : count - 1
        view.refresh()
    }
    
    func doneClicked() {
        interactor.addToBasket(with: productDetail.productId, count: count)
    }
}
extension ProductDetailPresenter: ProductDetailInteractorOutput {
    func handleBasketResult(_ result: BasketResult) {
        switch result {
        case .success(let response):
             basketResponse = response
            if let errorCode = basketResponse.errorCode, let title = basketResponse.message {
                switch errorCode {
                case ErrorCode.differentRestaurant.rawValue:
                    AlertInteraction.instance.showAlert(title: "Uyarı", text: title, item: self)
                default:
                    print("abc");
                }
            }
            else{
                AlertView.instance.showAlert(title: "Success", message: "Sepetinize başarıyla eklendi.", alertType: .success, alertedItem: self)
            }
        case .failure(let error):
            print(error)
        }
        
        //AlertInteraction.instance.showAlert()
    }
    
    func handleEmptyResult(_ result: BasketResult) {
        switch result {
        case .success(let response):
            let emtptyResponse = response
            if let errorCode = emtptyResponse.errorCode, errorCode == 200{
                interactor.addToBasket(with: productDetail.productId, count: count)
            }
        case .failure(let error):
            print(error)
    }
}
}

extension ProductDetailPresenter: AlertViewProtocol {
    func alertButtonClicked() {
      router.popView();
    }
}

extension ProductDetailPresenter: AlertInteractionProtocol {
    func acceptButtonClicked() {
        if let errorCode = basketResponse.errorCode {
            switch errorCode {
            case ErrorCode.differentRestaurant.rawValue:
                interactor.removeBasket()
            default:
                print("abc");
            }
        }
    }
}

