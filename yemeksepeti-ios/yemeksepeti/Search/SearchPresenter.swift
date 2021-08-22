//
//  SearchPresenter.swift
//  yemeksepeti
//
//  Created by semra on 17.08.2021.
//

import Foundation

protocol SearchPresenterInterface: BasePresenterInterface {
    var numberOfSections: Int { get }

    func numberOfItems(for index: Int) -> Int
    func section(for index: Int) -> RestaurantResponse?
    func item(index: IndexPath) -> ProductList?
    func didSelectRowAt(index: IndexPath)
    func fetchNextPage(by text: String)
    func searchButtonTapped(by text: String?)
}
protocol SearchDelegate: AnyObject {
    func navigateRestaurant(with id: Int)
}
extension SearchPresenter {
    fileprivate enum Constants {
        static let firstPageIndex: Int = 0
    }
}

final class SearchPresenter {
    private weak var view: SearchViewControllerInterface!
    private let interactor: SearchInteractorInterface!
    private var itemList: [SearchResponse] = []
    private var totalPage: Int?
    private let router: SearchRouterInterface!
    private var shouldFetchNextPage: Bool = true
    private var pageNumber: Int = Constants.firstPageIndex
    
    init(view: SearchViewControllerInterface,
         interactor: SearchInteractorInterface,
         router: SearchRouterInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension SearchPresenter: SearchPresenterInterface {
    var numberOfSections: Int {
        itemList.count
    }

    func viewDidLoad() {
        view.configure()
        view.setNavigationBarView()
    }

    func numberOfItems(for index: Int) -> Int {
        itemList[safe: index]?.productResponseList?.count ?? 0
    }

    func fetchSearchResults(by text: String, page: Int) {
        /*interactor.fetchResultList(by: text , page: page)*/
    }

    func section(for index: Int) -> RestaurantResponse? {
        if let item = itemList[safe: index] {
            return RestaurantResponse(type: item.type.rawValue,
                                      name: item.name,
                                      imageID: item.imageID,
                                      id: item.id,
                                      speed: item.speed,
                                      categoryName: item.categoryName,
                                      averageScore: item.averageScore,
                                      service: item.service,
                                      taste: item.taste,
                                      deliveryTime: item.deliveryTime)
        }
        return nil
    }
    
    func item(index: IndexPath) -> ProductList? {
        itemList[safe: index.section]?.productResponseList?[safe: index.row]
    }
    
    func didSelectRowAt(index: IndexPath){
        guard let item = item(index: index)else { return }
        router.navigateProduct(with: item)
    }

    func fetchNextPage(by text: String) {
        if shouldFetchNextPage {
            pageNumber += 1
            fetchSearchResults(by: text, page: pageNumber)
        }
    }

    func searchButtonTapped(by text: String?) {
        if let text = text, text.count > 0 {
           let textUtf = text.utf8
            pageNumber = 0
            interactor.fetchResultList(by: textUtf, page: 0)
        }
    }
}

extension SearchPresenter: SearchInteractorOutput {
    func handleSearchResult(_ result: SearchResult) {
        if(pageNumber == 0) {
            view?.hideLoadingView()
        }

        switch result {
        case .success(let response):
            if pageNumber == 0 {
                itemList = response.searchResponse
            } else {
                self.itemList.append(contentsOf: response.searchResponse)
            }
            totalPage = response.pageCount;
            shouldFetchNextPage = totalPage == pageNumber ? false : true
            if(itemList.count == 0){
                view.setEmptyView();
            }
            else{
                view.refresh();
            }
        case .failure(let error):
            print(error)
        }
    }
    
   
}

extension SearchPresenter: SearchDelegate {
    func navigateRestaurant(with id : Int) {
        router.navigateRestaurant(with: id)
    }
}
