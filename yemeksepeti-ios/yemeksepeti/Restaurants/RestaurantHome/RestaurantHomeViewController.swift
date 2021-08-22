//
//  RestaurantHomeViewController.swift
//  yemeksepeti
//
//  Created by semra on 14.08.2021.
//

import Foundation
import UIKit

protocol RestaurantHomeViewControllerInterface: AnyObject {
    
}

final class RestaurantHomeViewController: UIViewController {
    var presenter: RestaurantHomePresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension RestaurantHomeViewController: RestaurantHomeViewControllerInterface {
    
}
