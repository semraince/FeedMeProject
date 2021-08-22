//
//  TabBarRouter.swift
//  yemeksepeti
//
//  Created by semra on 14.08.2021.
//

import UIKit

final class TabBarRouter {
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func createModule() -> UITabBarController {
        let view = TabBarController()
        let presenter = TabBarPresenter(view: view)
        view.presenter = presenter
        return view
    }
}
