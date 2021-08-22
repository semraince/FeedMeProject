//
//  BasketItemCellPresenterInterface.swift
//  yemeksepeti
//
//  Created by semra on 21.08.2021.
//

import Foundation
protocol BasketPresenterDelegate {
    func addItem(with id: Int)
    func removeItem(with id: Int)
}

protocol BasketItemCellPresenterInterface {
    var imageURL: URL? { get }
    func load()
    
    func addButtonTapped()
    func removeButtonTapped()
}

final class BasketItemCellPresenter {
    private weak var view: BasketItemCellInterface!
    private let item: OrderItemDtoList
    private let basketDelegate: BasketPresenterDelegate?
    

    init(view: BasketItemCellInterface, item: OrderItemDtoList,delegate: BasketPresenterDelegate) {
        self.view = view
        self.item = item
        self.basketDelegate = delegate
    }
}

extension BasketItemCellPresenter: BasketItemCellPresenterInterface {
    var imageURL: URL? {
        let fullPath = "\(String(describing: item.imageId))".imageUrlPath
        if let url = URL(string: fullPath) {
            return url
        }
        return nil
    }
    func load(){
        view.prepareUI()
        view.setProductDescriptionLabel(with: item.name)
        view.setProductCountLabel(with: "\(item.count)" )
        view.setProductImageLabel(with: imageURL)
        view.setProductPrice(with: "\(item.totalPrice)" + " TL")
    }
    
    func addButtonTapped() {
        basketDelegate?.addItem(with: item.productId)
    }
    
    func removeButtonTapped() {
        if(item.count - 1 == 0){
            AlertInteraction.instance.showAlert(title: "Uyarı", text: "Ürünü sepetten çıkarmak istediğinize emin misiniz ?", item: self)
        }
        else {
            removeItem()
        }
    }
    func removeItem(){
        basketDelegate?.removeItem(with: item.productId)
    }
}

extension BasketItemCellPresenter: AlertInteractionProtocol {
    func acceptButtonClicked() {
        removeItem()
    }
}
