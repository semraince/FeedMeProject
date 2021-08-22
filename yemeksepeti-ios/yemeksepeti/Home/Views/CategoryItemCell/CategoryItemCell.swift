//
//  CategoryItemCell.swift
//  yemeksepeti
//
//  Created by semra on 15.08.2021.
//

import UIKit
import SDWebImage

extension CategoryItemCell {
    private enum Constant {
        static let containerViewCornerRadius: CGFloat = 8
    }
}

protocol CategoryItemCellInterface: AnyObject {
    func prepareUI()
    func configure()
}

final class CategoryItemCell: UICollectionViewCell {
    var presenter: CategoryItemCellPresenterInterface!
    @IBOutlet private weak var categoryImage: UIImageView!
    @IBOutlet private weak var categoryName: UILabel!
    @IBOutlet private weak var containerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
extension CategoryItemCell: CategoryItemCellInterface {
    func prepareUI() {
        containerView.layer.cornerRadius = Constant.containerViewCornerRadius
    }

    func configure() {
        categoryImage.sd_setImage(with: presenter.imageUrl, completed: nil)
        categoryName.text = presenter.name
    }
}
