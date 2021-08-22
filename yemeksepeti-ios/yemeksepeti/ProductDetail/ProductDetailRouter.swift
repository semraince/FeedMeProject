//
//  ProductDetailRouter.swift
//  yemeksepeti
//
//  Created by semra on 21.08.2021.
//

import Foundation

import UIKit

protocol ProductDetailRouterInterface: AnyObject {
    func popView()
}


final class ProductDetailRouter {
    private weak var view: UIViewController?
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController;
    }
    
    func createModule(with productDetail: ProductList) -> ProductDetailViewController {
        let view = UIStoryboard(name: "ProductDetail", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
        let interactor = ProductDetailInteractor()
        let presenter = ProductDetailPresenter(view: view,
                                                interactor: interactor,
                                                router: self,
                                                productDetail: productDetail
                                                )
        view.presenter = presenter
        self.view = view
        interactor.output = presenter
        return view
    }
}

extension ProductDetailRouter: ProductDetailRouterInterface {
    func popView() {
        navigationController?.popViewController(animated: true)
    }
}
