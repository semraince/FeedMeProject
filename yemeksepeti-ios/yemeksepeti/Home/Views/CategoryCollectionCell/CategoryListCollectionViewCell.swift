//
//  CategoryListCollectionViewCell.swift
//  yemeksepeti
//
//  Created by semra on 15.08.2021.
//

import UIKit

protocol CategoryListCollectionViewCellInterface: AnyObject {
    func configure()
}

final class CategoryListCollectionViewCell: UICollectionViewCell {
    var presenter: CategoryListCollectionPresenterInterface!
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
extension CategoryListCollectionViewCell: CategoryListCollectionViewCellInterface {
    func configure() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: CategoryItemCell.self)
        collectionView.reloadData()
    }
}

extension CategoryListCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellType: CategoryItemCell.self, indexPath: indexPath)
        if let item = presenter.categoryItem(indexPath: indexPath.row){
            let presenter = CategoryItemCellPresenter(view: cell, item: item)
            cell.presenter = presenter
            presenter.load()
        }
        return cell
    }
}

extension CategoryListCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width / 3, height: collectionView.bounds.width * 3/8)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row)
    }
}


