//
//  ProductListCollectionViewCell.swift
//  yemeksepeti
//
//  Created by semra on 19.08.2021.
//

import UIKit

protocol ProductListCollectionViewCellInterface: AnyObject {
    func setTitleLabel(with text: String)
    func setDescriptionLabel(with text: String)
}

final class ProductListCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var addButton: UIButton!

    var presenter: ProductListCellPresenterInterface? {
        didSet {
            presenter?.load()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        presenter?.addToBasket();
    }
}

//MARK: - ProductListCollectionViewCellInterface
extension ProductListCollectionViewCell: ProductListCollectionViewCellInterface {
    func setTitleLabel(with text: String) {
        titleLabel.text = text
    }

    func setDescriptionLabel(with text: String) {
        descriptionLabel.text = text
    }
}
