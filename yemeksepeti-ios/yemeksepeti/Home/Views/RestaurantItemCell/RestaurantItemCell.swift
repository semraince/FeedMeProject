//
//  ResturantItemCell.swift
//  yemeksepeti
//
//  Created by semra on 15.08.2021.
//

import UIKit
import SDWebImage

extension RestaurantItemCell {
    private enum Constant {
        static let starViewCornerRadius: CGFloat = 8
        static let restaurantImageCornerRadius: CGFloat = 12
        static let containerViewCornerRadius: CGFloat = 8
    }
}

protocol RestaurantItemCellInterface: AnyObject {
    func prepareUI()
    func configure()
}

final class RestaurantItemCell: UICollectionViewCell {
    @IBOutlet private weak var restaurantImage: UIImageView!
    @IBOutlet private weak var restaurantTitle: UILabel!
    @IBOutlet private weak var restaurantCategory: UILabel!
    @IBOutlet private weak var restaurantScore: UILabel!
    @IBOutlet private weak var restaurantDeliveryTime: UILabel!
    @IBOutlet private weak var restaurantMinimumPrice: UILabel!
    @IBOutlet private weak var restaurantStarContainerStackView: UIStackView!
    @IBOutlet private weak var containerView: UIView!

    var presenter: RestaurantItemCellPresenterInterface!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension RestaurantItemCell: RestaurantItemCellInterface {
    func prepareUI() {
        restaurantStarContainerStackView.layer.cornerRadius = Constant.starViewCornerRadius
        restaurantImage.layer.cornerRadius = Constant.restaurantImageCornerRadius
        containerView.layer.cornerRadius = Constant.containerViewCornerRadius
    }

    func configure() {
        restaurantImage.sd_setImage(with: presenter.imageUrl, completed: nil)
        restaurantTitle.text = presenter.name
        restaurantCategory.text = presenter.category
        restaurantScore.text = presenter.score
        restaurantDeliveryTime.text = presenter.deliveryTime
        restaurantMinimumPrice.text = presenter.speed
    }
}
