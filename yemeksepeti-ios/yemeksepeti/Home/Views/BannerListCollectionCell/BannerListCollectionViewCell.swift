//
//  BannerListCollectionViewCell.swift
//  yemeksepeti
//
//  Created by semra on 14.08.2021.
//

import UIKit

protocol BannerListCollectionViewCellInterface: AnyObject {
    func configure()
}

final class BannerListCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var presenter: BannerListCollectionPresenterInterface!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension BannerListCollectionViewCell: BannerListCollectionViewCellInterface {
    func configure() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: BannerItemCell.self)
        collectionView.reloadData()
    }
}

extension BannerListCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellType: BannerItemCell.self, indexPath: indexPath)
        if let item = presenter.bannerItem(indexPath: indexPath.row){
            let presenter = BannerItemCellPresenter(view: cell, item: item)
            cell.presenter = presenter
            presenter.load()
        }
        return cell
    }
}

extension BannerListCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: 200)
    }
}
