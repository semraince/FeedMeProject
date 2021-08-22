//
//  CategoryDetailRouter.swift
//  yemeksepeti
//
//  Created by semra on 17.08.2021.
//

import Foundation
import UIKit

protocol CategoryDetailRouterInterface: AnyObject {
    func navigateRestaurant(by restaurantId : Int)
}

final class CategoryDetailRouter {
    private weak var navigationController: UINavigationController?
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    
    func createModule(by categoryId: Int) -> CategoryDetailViewController {
        let catView = UIStoryboard(name: "CategoryDetail", bundle: nil).instantiateViewController(withIdentifier: "CategoryDetailViewController") as! CategoryDetailViewController
        let interactor = CategoryDetailInteractor()
        let presenter = CategoryDetailPresenter(view: catView,
                                                interactor: interactor,
                                                router: self,
                                                categoryId: categoryId,
                                                viewWidth: Double(UIScreen.main.bounds.width))
        catView.presenter = presenter
        interactor.output = presenter
        return catView
    }
}

extension CategoryDetailRouter: CategoryDetailRouterInterface {
    func navigateRestaurant(by restaurantId: Int) {
        let restaurantDetailRouter = RestaurantDetailRouter(navigationController: navigationController)
        let vc = restaurantDetailRouter.createModule(by: restaurantId)
        navigationController?.pushViewController(vc, animated: true)
    }
}
