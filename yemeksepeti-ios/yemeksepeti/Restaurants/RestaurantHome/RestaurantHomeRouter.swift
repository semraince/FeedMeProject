//
//  RestaurantHomeRouter.swift
//  yemeksepeti
//
//  Created by semra on 14.08.2021.
//

import Foundation
import UIKit


final class RestaurantHomeRouter {
    static func createModule() -> RestaurantHomeViewController {
        let view = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "RestaurantHomeViewController") as! RestaurantHomeViewController
        let presenter = RestaurantHomePresenter(view: view)
        view.presenter = presenter
        return view
    }
}
