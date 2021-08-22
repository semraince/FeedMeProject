//
//  HomePresenter.swift
//  yemeksepeti
//
//  Created by semra on 14.08.2021.
//

import Foundation

protocol HomePresenterInterface: BasePresenterInterface {
    var numberOfItems: Int { get }
    
    func item(index: Int) -> MainResponseItemList?
    func sizeForItem(index: Int) -> (width: Double, height: Double)
    func didSelectRowAt(index: Int)
    func fetchNextPage()
}

protocol HomeCategoryDelegate {
    func navigateCategory(by categoryId: Int)
}

extension HomePresenter {
    fileprivate enum Constants {
        static let firstPageIndex: Int = 0
    }
}

final class HomePresenter {
    private weak var view: HomeViewControllerInterface!
    private let interactor: HomeInteractorInterface!
    private var itemList: [MainResponseItemList] = []
    private var totalPage: Int?
    private let viewWidth: Double
    private let router: HomeRouterInterface!
    private var shouldFetchNextPage: Bool = true
    private var pageNumber: Int = Constants.firstPageIndex
    
    init(view: HomeViewControllerInterface,
         interactor: HomeInteractorInterface,
         router: HomeRouterInterface,
         viewWidth: Double = 0.0) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.viewWidth = viewWidth
    }
}

extension HomePresenter: HomePresenterInterface {
    var numberOfItems: Int {
        itemList.count 
    }
    
    func viewDidLoad() {
        view.showLoadingView()
        view.configure()
        fetchRestaurants(page: pageNumber)
    }

    func viewWillAppear() {
        view.setNavigationBarView()
    }

    func fetchRestaurants(page: Int) {
        interactor.fetchAddressList(page: pageNumber)
    }
    
    func item(index: Int) -> MainResponseItemList? {
        itemList[safe: index]
    }
    
    func sizeForItem(index: Int) -> (width: Double, height: Double) {
        guard let item = itemList[safe: index] else {  return (0,0) }
        switch  item.type {
        case .banner:
            return (viewWidth, viewWidth * 3/8)
        case .category:
            return (viewWidth, viewWidth * 3/8)
        case .item:
            return (viewWidth, 80)
        }
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

extension HomePresenter: HomeCategoryDelegate {
    func navigateCategory(by categoryId: Int) {
        router.navigateCategory(by: categoryId)
    }
}

extension HomePresenter: HomeInteractorOutput {
    func handleHomeResult(_ result: HomeResult) {
        view?.hideLoadingView()
        switch result {
        case .success(let response):
            self.itemList.append(contentsOf: response.mainResponseItemList)
            totalPage = response.totalPages;
            shouldFetchNextPage = totalPage == pageNumber ? false : true
            view.refresh();
        case .failure(let error):
            print(error)
        }
    }
}
