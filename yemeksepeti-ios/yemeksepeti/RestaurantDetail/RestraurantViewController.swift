//
//  RestraurantViewController.swift
//  yemeksepeti
//
//  Created by semra on 14.08.2021.
//

import Foundation
import UIKit

protocol RestaurantDetailViewControllerInterface: BaseViewController {
    func setNavigationView()
    func prepareCollectionView()
}

final class RestaurantDetailViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var headerView: RestaurantHeaderView!

    var presenter: RestaurantDetailPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
        
    }
}

//MARK: - RestaurantDetailViewControllerInterface
extension RestaurantDetailViewController: RestaurantDetailViewControllerInterface {
    func setNavigationView() {
        prepareNavigationBarView()
    }
    
    func prepareCollectionView() {
        let restaurantHeaderPresenter = RestaurantHeaderPresenter(view: headerView,
                                                                  item: presenter.restaurantDetailItem!)
        headerView.presenter = restaurantHeaderPresenter
        headerView.configure()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: ProductListCollectionViewCell.self)
        collectionView.reloadData()
    }
}

//MARK: - UICollectionViewDataSource
extension RestaurantDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        presenter.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.sectionForItems(for: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellType: ProductListCollectionViewCell.self, indexPath: indexPath)
        if let item = presenter.item(for: indexPath) {
            let productListPresenter = ProductListCellPresenter(view: cell,
                                                                item: item,
                                                                restaurantDelegate: presenter as! RestaurantProductDelegate)
            cell.presenter = productListPresenter
        }
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension RestaurantDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectRow(for: indexPath)
    }
}
