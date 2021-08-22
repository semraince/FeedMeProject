//
//  RestaurantHeaderView.swift
//  yemeksepeti
//
//  Created by semra on 17.08.2021.
//

import UIKit
import SDWebImage

extension RestaurantHeaderView {
    private enum Constant {
        static let starViewCornerRadius: CGFloat = 8
        static let restaurantImageCornerRadius: CGFloat = 12
        static let containerViewCornerRadius: CGFloat = 8
    }
}

protocol RestaurantHeaderViewInterface: AnyObject {
    func prepareUI()
    func configure()
}

final class RestaurantHeaderView: UIView {
    @IBOutlet private weak var restaurantImage: UIImageView!
    @IBOutlet private weak var restaurantTitle: UILabel!
    @IBOutlet private weak var restaurantCategory: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var restaurantStarContainerStackView: UIStackView!
    @IBOutlet private weak var averageLabel: UILabel!
    @IBOutlet private weak var speedLabel: UILabel!

    var presenter: RestaurantHeaderPresenterInterface!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let view = self.nibInstantiate(autoResizingMask: [.flexibleHeight,
                                                          .flexibleWidth])
        view.frame = self.bounds
        addSubview(view)
    }
}

extension RestaurantHeaderView: RestaurantHeaderViewInterface {
    func prepareUI() {
        containerView.layer.cornerRadius = Constant.containerViewCornerRadius
        containerView.layer.borderColor = UIColor.gray.cgColor
        containerView.layer.borderWidth = 1
        restaurantStarContainerStackView.layer.cornerRadius = Constant.starViewCornerRadius
        restaurantStarContainerStackView.layer.borderWidth = 1
        restaurantImage.layer.cornerRadius = Constant.restaurantImageCornerRadius
    }

    func configure() {
        restaurantImage.sd_setImage(with: presenter.imageUrl, completed: nil)
        restaurantTitle.text = presenter.name
        restaurantCategory.text = presenter.category
        scoreLabel.text = presenter.score
        averageLabel.text = presenter.deliveryTime
        speedLabel.text = presenter.speed
    }
}
