//
//  HomeViewController.swift
//  yemeksepeti
//
//  Created by semra on 14.08.2021.
//

import UIKit

protocol HomeViewControllerInterface: BaseViewController {
    func configure()
    func refresh()
    func setNavigationBarView()
}

final class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: HomePresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setNavigationBarView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()

    }
}

extension HomeViewController: HomeViewControllerInterface {
    func setNavigationBarView() {
        prepareNavigationBarViewWithTitle("YemekSepeti")
    }

    func configure() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: RestaurantItemCell.self)
        collectionView.register(cellType: BannerListCollectionViewCell.self)
        collectionView.register(cellType: CategoryListCollectionViewCell.self)
    }

    func refresh() {
        collectionView.reloadData()
    }
    
    func showLoadingView() {
        showLoading()
    }
    
    func hideLoadingView() {
        hideLoading()
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let item = presenter.item(index: indexPath.row) {
            switch item.type {
            case .banner:
                if let homeResponseItem = item.homeResponseItemList {
                    let cell = collectionView.dequeueReusableCell(cellType: BannerListCollectionViewCell.self, indexPath: indexPath)
                    let presenter = BannerListCollectionPresenter(view: cell, list: homeResponseItem)
                    cell.presenter = presenter
                    presenter.load();
                    return cell;
                }
                
            case .category:
                if let categoryItem = item.homeResponseItemList {
                    let cell = collectionView.dequeueReusableCell(cellType: CategoryListCollectionViewCell.self, indexPath: indexPath)
                    let categoryPresenter = CategoryListCollectionPresenter(view: cell, list: categoryItem, delegate: presenter as! HomeCategoryDelegate)
                    cell.presenter = categoryPresenter
                    categoryPresenter.load();
                    return cell;
                }
            case .item:
                let cell = collectionView.dequeueReusableCell(cellType: RestaurantItemCell.self, indexPath: indexPath)
                let presenter = RestaurantItemCellPresenter(view: cell, item: item)
                cell.presenter = presenter
                presenter.load()
                return cell
            }
        }
        return UICollectionViewCell()
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = presenter.sizeForItem(index: indexPath.row)
        return CGSize(width: size.width, height: size.height)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView == collectionView,
              (scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height else { return }
        presenter.fetchNextPage();
    }
}
