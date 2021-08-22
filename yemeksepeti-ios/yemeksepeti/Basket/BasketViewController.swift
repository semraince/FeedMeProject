//
//  BasketViewController.swift
//  yemeksepeti
//
//  Created by semra on 21.08.2021.
//

import UIKit

protocol BasketViewControllerInterface: BaseViewController {
    func configure()
    func reloadData()
    func setEmptyView()
    func showBottomView()
    func hideBottomView()
}

final class BasketViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var totalLabel: UILabel!
    @IBOutlet private weak var totalPrice: UILabel!
    @IBOutlet private weak var bottomStackView: UIStackView!
    @IBOutlet private weak var orderButton: UIButton!
    
    var presenter: BasketPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    

    @IBAction func orderButtonClicked() {
        presenter.createOrder()
    }
}

extension BasketViewController: BasketViewControllerInterface {
    func configure() {
        orderButton.layer.cornerRadius = 5
        orderButton.layer.borderWidth = 1
        orderButton.layer.borderColor = UIColor.black.cgColor
        collectionView.restore()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: BasketItemCell.self)
        collectionView.register(reusableViewType: RestaurantInformationView.self,
                                ofKind: UICollectionView.elementKindSectionHeader)
    }

    func setEmptyView() {
        collectionView.setEmptyView(title: "Sepetin boş", message: "Sepetinde ürün bulunmamaktadır. Hemen alışverişe başla", imageName: "emptyBasket" )
    }

    func reloadData() {
        totalPrice.text = presenter.totalPrice
        collectionView.reloadData()
    }

    func showBottomView() {
        bottomStackView.isHidden = false
    }

    func hideBottomView() {
        bottomStackView.isHidden = true
    }
}

extension BasketViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellType: BasketItemCell.self, indexPath: indexPath)
        if let item = presenter.item(index: indexPath.row) {
            let cellPresenter = BasketItemCellPresenter(view: cell, item: item, delegate: presenter as! BasketPresenterDelegate)
            cell.presenter = cellPresenter
            cellPresenter.load()
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "RestaurantInformationView", for: indexPath) as! RestaurantInformationView
            if let restaurantDetail = presenter.restaurantDetail {
                reusableview.prepareUI()
                reusableview.configure(item: restaurantDetail)
            }
            return reusableview

        default:
            fatalError("Unexpected element kind")
        }
    }
}

extension BasketViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 80)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: CGFloat(presenter.sectionHeight))
    }
}
