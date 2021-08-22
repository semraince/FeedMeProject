//
//  SearchViewController.swift
//  yemeksepeti
//
//  Created by semra on 17.08.2021.
//

import UIKit
import IQKeyboardManagerSwift

protocol SearchViewControllerInterface: BaseViewController {
    func configure()
    func refresh()
    func setNavigationBarView()
    func setEmptyView()
}

final class SearchViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var searchButton: UIButton!

    var presenter: SearchPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

    @IBAction private func saerchButtonTapped() {
        presenter.searchButtonTapped(by: searchTextField.text)
    }
}

extension SearchViewController: SearchViewControllerInterface {
    func setNavigationBarView() {
        prepareNavigationBarViewWithTitle("Arama")
    }

    func configure() {
        searchButton.layer.borderWidth = 1
        searchButton.layer.cornerRadius = 8
        searchButton.layer.borderColor = UIColor.gray.cgColor
        searchTextField.placeholder = "Restoran, ürün ya da mutfak arayın..."
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: ProductListCollectionViewCell.self)
        collectionView.register(reusableViewType: RestaurantInformationView.self,
                                ofKind: UICollectionView.elementKindSectionHeader)
    }

    func configureKeyboardManager() {
        
    }
    
    func refresh() {
        collectionView.restore()
        collectionView.reloadData()
    }

    func setEmptyView() {
        collectionView.setEmptyView(title: "İlgili sonuç bulunamadı", message: "Farklı ürün restoran veya mutfak içinde aramayı tekrar deneyin", imageName: "searchNotFound")
    }
}

//MARK: - UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        presenter.numberOfSections
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems(for: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellType: ProductListCollectionViewCell.self, indexPath: indexPath)
        if let item = presenter.item(index: indexPath) {
            let productListPresenter = ProductListCellPresenter(view: cell,
                                                                item: item, restaurantDelegate: nil)
            cell.presenter = productListPresenter
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "RestaurantInformationView", for: indexPath) as! RestaurantInformationView
           
            if let item = presenter.section(for: indexPath.section) {
                reusableview.prepareUI()
                reusableview.id = item.id
                reusableview.searchDelegate = presenter as! SearchDelegate 
                reusableview.configure(item: item)
            }
            return reusableview

        default:
            fatalError("Unexpected element kind")
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 80)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath)
    }
}
