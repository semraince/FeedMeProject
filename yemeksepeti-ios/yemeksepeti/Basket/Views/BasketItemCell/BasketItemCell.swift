//
//  BasketItemCell.swift
//  yemeksepeti
//
//  Created by semra on 21.08.2021.
//

import UIKit
import SDWebImage

private enum Constant {
    static let basketImageCornerRadius: CGFloat = 12
}

protocol BasketItemCellInterface: AnyObject {
    func prepareUI()
    func setProductDescriptionLabel(with text: String)
    func setProductCountLabel(with text: String)
    func setProductImageLabel(with url:URL?)
    func setProductPrice(with text: String)
    
}

final class BasketItemCell: UICollectionViewCell {
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var productCountLabel: UILabel!
    @IBOutlet private weak var decraseQuantityButton: UIButton!
    @IBOutlet private weak var increaseQuantityButton: UIButton!
    @IBOutlet private weak var productImage: UIImageView!
    
    
    @IBOutlet weak var productPrice: UILabel!
    
    var presenter: BasketItemCellPresenterInterface!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction private func addToBasketButtonTapped() {
        presenter.addButtonTapped()
    }
    
    @IBAction private func removeToBasketButtonTapped() {
        presenter.removeButtonTapped()
    }
}
extension BasketItemCell: BasketItemCellInterface {
    func prepareUI() {
        increaseQuantityButton.layer.cornerRadius = 12
        decraseQuantityButton.layer.cornerRadius = 12
        increaseQuantityButton.layer.borderWidth = 1
        increaseQuantityButton.layer.borderColor = UIColor.red.cgColor
        decraseQuantityButton.layer.borderWidth = 1
        decraseQuantityButton.layer.borderColor = UIColor.red.cgColor
        layer.cornerRadius = 1
        productImage.layer.cornerRadius = Constant.basketImageCornerRadius
    }
    
    func setProductDescriptionLabel(with text: String) {
        descriptionLabel.text = text
    }
    
    func setProductCountLabel(with text: String) {
        productCountLabel.text = text
    }
    
    func setProductPrice(with text: String){
        productPrice.text = text
    }
    
    func setProductImageLabel(with url:URL?){
        productImage.sd_setImage(with: presenter.imageURL, completed: nil)
    }
}
