//
//  SearchRouter.swift
//  yemeksepeti
//
//  Created by semra on 17.08.2021.
//

import Foundation
import UIKit

protocol SearchRouterInterface: AnyObject {
    func navigateRestaurant(with id: Int)
    func navigateProduct(with product: ProductList)
}

final class SearchRouter {
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController;
    }
    
    func createModule() -> SearchViewController {
        let view = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        let interactor = SearchInteractor()
        let presenter = SearchPresenter(view: view,
                                        interactor: interactor,
                                        router: self)
        view.tabBarItem.image = UIImage(named: "search-24")
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
}

extension SearchRouter: SearchRouterInterface {
    func navigateRestaurant(with id: Int){
        let restaurantDetailRouter = RestaurantDetailRouter(navigationController: navigationController)
        let vc = restaurantDetailRouter.createModule(by: id)
        navigationController?.pushViewController(vc, animated: true)
        }
    func navigateProduct(with product: ProductList){
        let productDetailRouter = ProductDetailRouter(navigationController: navigationController)
          let vc = productDetailRouter.createModule(with: product)
          navigationController?.pushViewController(vc, animated: true)
    }
    
}
