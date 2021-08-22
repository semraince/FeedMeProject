//
//  CategoryDetailViewController.swift
//  yemeksepeti
//
//  Created by semra on 17.08.2021.
//

import UIKit

protocol CategoryDetailViewControllerInterface: BaseViewController {
    func configure()
    func refresh()
}

final class CategoryDetailViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var presenter: CategoryDetailPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension CategoryDetailViewController: CategoryDetailViewControllerInterface {
    func configure() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: RestaurantItemCell.self)
    }
    
    func refresh() {
        collectionView.reloadData()
    }
}

extension CategoryDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellType: RestaurantItemCell.self, indexPath: indexPath)
        if let item = presenter.item(index: indexPath.row) {
            let presenter = RestaurantItemCellPresenter(view: cell, item: item)
            cell.presenter = presenter
            presenter.load()
        }
        return cell
    }
}

extension CategoryDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = presenter.sizeForItem(index: indexPath.row)
        return CGSize(width: size.width, height: size.height)
    }
}

extension CategoryDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView == collectionView,
              (scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height else { return }
        presenter.fetchNextPage()
    }
}
