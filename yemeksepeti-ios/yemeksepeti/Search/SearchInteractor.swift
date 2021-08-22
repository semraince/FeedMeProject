//
//  SearchInteractor.swift
//  yemeksepeti
//
//  Created by semra on 17.08.2021.
//

import Foundation
import NetworkAPI

//MARK: - SearchList
struct SearchList: Decodable {
    let pageCount: Int
    let searchResponse: [SearchResponse]
}

//MARK: - SearchResponse
struct SearchResponse: Decodable {
    let type: TypeEnum
    let name: String
    let imageID, id: Int
    let speed: Double
    let categoryName: String
    let averageScore, service, taste: Double
    let deliveryTime: String
    let productResponseList: [ProductList]?
}

typealias SearchResult = APIResponse<SearchList>

protocol SearchInteractorInterface {
    func fetchResultList(by text: String.UTF8View, page: Int)
}

protocol SearchInteractorOutput {
    func handleSearchResult(_ result: SearchResult)
}

final class SearchInteractor {
    weak var presenter: SearchPresenterInterface?
    var output: SearchInteractorOutput?
}

extension SearchInteractor: SearchInteractorInterface {
    func fetchResultList(by text: String.UTF8View, page: Int) {
        APIClient.shared.request(responseType: SearchList.self, router: SearchEndpointItem.result(text: text, page: page, userId: nil)) { [weak self] result in
            print(result)
            self?.output?.handleSearchResult(result)
            
        }
    }
}

