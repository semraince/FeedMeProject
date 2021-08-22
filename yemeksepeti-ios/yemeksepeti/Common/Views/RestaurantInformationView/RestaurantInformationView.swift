//
//  RestaurantInformationView.swift
//  yemeksepeti
//
//  Created by semra on 21.08.2021.
//

import UIKit
import SDWebImage

extension RestaurantInformationView {
    private enum Constant {
        static let starViewCornerRadius: CGFloat = 8
        static let restaurantImageCornerRadius: CGFloat = 12
        static let containerViewCornerRadius: CGFloat = 8
    }
}

protocol RestaurantInformationViewInterface: AnyObject {
    func prepareUI()
    func configure(item: RestaurantResponse)
}

final class RestaurantInformationView: UICollectionReusableView {
    @IBOutlet private weak var restaurantImage: UIImageView!
    @IBOutlet private weak var restaurantTitle: UILabel!
    @IBOutlet private weak var restaurantCategory: UILabel!
    @IBOutlet private weak var restaurantScore: UILabel!
    @IBOutlet private weak var restaurantDeliveryTime: UILabel!
    @IBOutlet private weak var restaurantMinimumPrice: UILabel!
    @IBOutlet private weak var restaurantStarContainerStackView: UIStackView!
    weak var searchDelegate: SearchDelegate?
    var id: Int?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        if let restaurantId = id {
            searchDelegate?.navigateRestaurant(with: restaurantId)
        }
        
    }
}

extension RestaurantInformationView: RestaurantInformationViewInterface {
    func prepareUI() {
        restaurantStarContainerStackView.layer.cornerRadius = Constant.starViewCornerRadius
        restaurantImage.layer.cornerRadius = Constant.restaurantImageCornerRadius
        layer.cornerRadius = Constant.containerViewCornerRadius
    }

    func configure(item: RestaurantResponse) {
        restaurantImage.sd_setImage(with: URL(string: "\(String(describing: item.imageID))".imageUrlPath), completed: nil)
        restaurantTitle.text = item.name
        restaurantCategory.text = item.categoryName
        restaurantScore.text = "\(item.averageScore)"
        restaurantDeliveryTime.text = item.deliveryTime
        restaurantMinimumPrice.text = "\(item.speed) Hız"
    }
    
    
}

