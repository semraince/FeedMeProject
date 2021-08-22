//
//  ProductDetailViewController.swift
//  yemeksepeti
//
//  Created by semra on 21.08.2021.
//

import Foundation
import UIKit
import SDWebImage

protocol ProductDetailViewControllerInterface: BaseViewController {
    func configure()
    func refresh()
}

final class ProductDetailViewController: UIViewController {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var producIngredients: UILabel!
    
    var presenter: ProductDetailPresenterInterface!
    
    @IBOutlet weak var productCount: UILabel!
    
    @IBOutlet weak var totalPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()

    }
    
    
    @IBAction func removeButtonClicked(_ sender: Any) {
        presenter.removeClicked()
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        presenter.addClicked()
    }
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        presenter.doneClicked()
    }
}
extension ProductDetailViewController: ProductDetailViewControllerInterface {
    func configure(){
        productImageView.sd_setImage(with: presenter.imageURL, completed: nil)
        refresh()
        
        
    }
    func refresh() {
        productName.text = presenter.productName
        producIngredients.text = presenter.productIngredients
        productCount.text = presenter.productCount
        totalPrice.text = presenter.productPrice
    }
    
}
