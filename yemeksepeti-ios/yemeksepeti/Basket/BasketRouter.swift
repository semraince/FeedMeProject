//
//  BasketRouter.swift
//  yemeksepeti
//
//  Created by semra on 21.08.2021.
//

import Foundation
import UIKit

protocol BasketRouterInterface: AnyObject {
}

final class BasketRouter {
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController;
    }
    
    func createModule() -> BasketViewController {
        let view = UIStoryboard(name: "Basket", bundle: nil).instantiateViewController(withIdentifier: "BasketViewController") as! BasketViewController
        let interactor = BasketInteractor()
        let presenter = BasketPresenter(view: view,
                                        interactor: interactor,
                                        router: self)
        view.tabBarItem.image = UIImage(named: "basket-24")
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
}

extension BasketRouter: BasketRouterInterface {
}
