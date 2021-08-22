//
//  CategoryDetailPresenter.swift
//  yemeksepeti
//
//  Created by semra on 17.08.2021.
//

import Foundation

protocol CategoryDetailPresenterInterface: BasePresenterInterface {
    var numberOfItems: Int { get }
    
    func sizeForItem(index: Int) -> (width: Double, height: Double) 
    func item(index: Int) -> MainResponseItemList?
    func didSelectRowAt(index: Int)
    func fetchNextPage()
}

extension CategoryDetailPresenter {
    fileprivate enum Constants {
        static let firstPageIndex: Int = 0
    }
}

final class CategoryDetailPresenter {
    private weak var view: CategoryDetailViewControllerInterface!
    private let interactor: CategoryDetailInteractorInterface!
    private var itemList: [MainResponseItemList] = []
    private var totalPage: Int?
    private let router: CategoryDetailRouterInterface!
    private var shouldFetchNextPage: Bool = true
    private var pageNumber: Int = Constants.firstPageIndex
    private let categoryId: Int
    private let viewWidth: Double
    
    init(view: CategoryDetailViewControllerInterface,
         interactor: CategoryDetailInteractorInterface,
         router: CategoryDetailRouterInterface,
         categoryId: Int,
         viewWidth: Double) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.categoryId = categoryId
        self.viewWidth = viewWidth
    }
}

extension CategoryDetailPresenter: CategoryDetailPresenterInterface {
    var numberOfItems: Int {
        itemList.count
    }
    
    func viewDidLoad() {
        view.showLoadingView()
        view.configure()
        fetchRestaurants(page: pageNumber)
    }

    func fetchRestaurants(page: Int) {
        interactor.fetchCategoryDetail(by: categoryId, page: page)
    }
    
    func item(index: Int) -> MainResponseItemList? {
        itemList[safe: index]
    }
    
    func sizeForItem(index: Int) -> (width: Double, height: Double) {
        guard let item = itemList[safe: index] else { return (0,0) }
        return(viewWidth, 80)
    }

    func didSelectRowAt(index: Int){
        guard let item = itemList[safe: index] else { return }
        guard let id = item.id else {
            return
        }
        router.navigateRestaurant(by: id)
        //router.navigateRestaurants();
    }
    
    func fetchNextPage() {
        if shouldFetchNextPage {
            pageNumber += 1
            fetchRestaurants(page: pageNumber)
        }
    }
}

extension CategoryDetailPresenter: CategoryDetailInteractorOutput {
    func handleCategoryResult(_ result: HomeResult) {
        if(pageNumber == 0){
            view?.hideLoadingView()
        }
        switch result {
        case .success(let response):
            self.itemList.append(contentsOf: response.mainResponseItemList)
            totalPage = response.totalPages;
            shouldFetchNextPage = totalPage == pageNumber ? false : true
            view.refresh();
        case .failure(let error):
            print(error)
            print("hata")
        }
    }
}

