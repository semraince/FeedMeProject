//
//  HomeInteractor.swift
//  yemeksepeti
//
//  Created by semra on 14.08.2021.
//

import Foundation
import NetworkAPI

struct HomeResponse: Decodable {
    let totalPages: Int
    let mainResponseItemList: [MainResponseItemList]
}

// MARK: - MainResponseItemList
struct MainResponseItemList: Decodable {
    let type: TypeEnum
    let name: String?
    let homeResponseItemList: [HomeResponseItemList]?
    let imageID, id: Int?
    let speed, service, taste, averageScore: Double?
    let deliveryTime, categoryName: String?
}

enum TypeEnum: String, Decodable {
    case banner = "banner"
    case category = "category"
    case item = "item"
}
struct HomeResponseItemList: Decodable {
    let imageID, id: Int
    let name: String
}

typealias HomeResult = APIResponse<HomeResponse>

// MARK: - ProductType
protocol HomeInteractorInterface {
    // AddressListPresenter -> AddressListInteractor
    func fetchAddressList(page: Int)
    //func createUser(email: String, userId: String)
}

protocol HomeInteractorOutput {
    func handleHomeResult(_ result: HomeResult)
}

final class HomeInteractor {
    weak var presenter: HomePresenterInterface?
    var output: HomeInteractorOutput?
}

extension HomeInteractor: HomeInteractorInterface {
    func fetchAddressList(page: Int) {
        APIClient.shared.request(responseType: HomeResponse.self, router: HomeEndpointItem.home(page: page, userId: nil)) { [weak self] result in
            print(result)
            self?.output?.handleHomeResult(result)
            
        }
    }
    /*func createUser(email: String, userId: String) {
        APIClient.shared.request(responseType: CreateUserResponse.self, router: UserEndpointItem.createUser(email: "sss@gmail.com", userId: "1234568984")) {  [weak self] result in
            print(result)
        }
    }*/
}
