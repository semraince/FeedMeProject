//
//  RestaurantDetailRouter.swift
//  yemeksepeti
//
//  Created by semra on 14.08.2021.
//

import Foundation
import UIKit

protocol RestaurantDetailRouterInterface {
    func navigateProductDetail(with product: ProductList)
}

final class RestaurantDetailRouter {
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController;
    }
    
     func createModule(by restaurantId: Int) -> RestaurantDetailViewController {
        let interactor = RestaurantDetailInteractor()
        let view = UIStoryboard(name: "RestaurantDetail", bundle: nil).instantiateViewController(withIdentifier: "RestaurantDetailViewController") as! RestaurantDetailViewController
        let presenter = RestaurantDetailPresenter(view: view,
                                                  interactor: interactor,
                                                  router: self,
                                                  restaurantId: restaurantId)
        view.presenter = presenter
        interactor.output = presenter
        presenter.viewDidLoad()
        return view
    }
}

extension RestaurantDetailRouter: RestaurantDetailRouterInterface {
    func navigateProductDetail(with product: ProductList) {
      let productDetailRouter = ProductDetailRouter(navigationController: navigationController)
        let vc = productDetailRouter.createModule(with: product)
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
