//
//  HomeRouter.swift
//  yemeksepeti
//
//  Created by semra on 14.08.2021.
//

import Foundation
import UIKit

protocol HomeRouterInterface: AnyObject {
    func navigateRestaurant(by restaurantId : Int)
    func navigateCategory(by categoryId: Int)
}

final class HomeRouter {
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController;
    }

    func createModule() -> HomeViewController {
        let view = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let interactor = HomeInteractor()
        let presenter = HomePresenter(view: view,
                                      interactor: interactor,
                                      router: self,
                                      viewWidth: Double(UIScreen.main.bounds.width))
        view.tabBarItem.image = UIImage(named: "home-24")
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
}

extension HomeRouter: HomeRouterInterface{
    func navigateRestaurant(by restaurantId: Int) {
        let restaurantDetailRouter = RestaurantDetailRouter(navigationController: navigationController)
        let vc = restaurantDetailRouter.createModule(by: restaurantId)
        navigationController?.pushViewController(vc, animated: true)
        //AlertInteraction.instance.showAlert()
    }

    func navigateCategory(by categoryId: Int) {
        let categoryRouter = CategoryDetailRouter(navigationController: navigationController)
        let vc = categoryRouter.createModule(by: categoryId)
        navigationController?.pushViewController(vc, animated: true)
    }
}
