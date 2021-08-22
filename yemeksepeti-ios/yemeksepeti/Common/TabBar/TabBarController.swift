//
//  TabBarController.swift
//  yemeksepeti
//
//  Created by semra on 14.08.2021.
//

import UIKit

protocol TabBarControllerInterface: AnyObject {
    func setViewControllers()
}
public final class TabBarController: UITabBarController {
    var presenter: TabBarPresenterInterface! {
        didSet {
            presenter.load()
        }
    }
    
    lazy var homeViewController: UIViewController = {
        let navigationController = UINavigationController()
        let homeRouter = HomeRouter(navigationController: navigationController)
        let homepage = homeRouter.createModule()
       
        navigationController.viewControllers = [homepage]
        navigationController.title = "Home"
        return navigationController
    }()
    
    lazy var searchViewController: UIViewController = {
        let navigationController = UINavigationController()
        let searchRouter = SearchRouter(navigationController: navigationController)
        let searchPage = searchRouter.createModule()
       
        navigationController.viewControllers = [searchPage]
        navigationController.title = "Search"
        return navigationController
    }()
    
    lazy var basketViewController: UIViewController = {
        let navigationController = UINavigationController()
        let basketRouter = BasketRouter(navigationController: navigationController)
        let basketPage = basketRouter.createModule()
       
        navigationController.viewControllers = [basketPage]
        navigationController.title = "Basket"
        return navigationController
    }()
}

extension TabBarController: TabBarControllerInterface {
    func setViewControllers() {
        viewControllers = [homeViewController, searchViewController, basketViewController]
    }
}
