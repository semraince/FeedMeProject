//
//  BannerItemCell.swift
//  yemeksepeti
//
//  Created by semra on 14.08.2021.
//

import UIKit
import SDWebImage

protocol BannerItemCellInterface: AnyObject {
    func configure()
    
}
final class BannerItemCell: UICollectionViewCell {
    var presenter: BannerItemCellPresenterInterface!
    @IBOutlet weak var bannerImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
extension BannerItemCell: BannerItemCellInterface {
    func configure() {
        bannerImage.sd_setImage(with: presenter.imageUrl, completed: nil)
    }
}
