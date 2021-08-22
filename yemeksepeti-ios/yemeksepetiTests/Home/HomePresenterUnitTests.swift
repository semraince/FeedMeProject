//
//  HomePresenterUnitTests.swift
//  yemeksepetiTests
//
//  Created by semra on 22.08.2021.
//

@testable import yemeksepeti
import XCTest

final class HomePresenterUnitTests: XCTestCase {
    private var view: MockHomeViewController!
    private var router: MockHomeRouter!
    private var interactor: MockHomeInteractor!
    private var presenter: HomePresenter!
    var response: HomeResponse!

    override func setUp() {
        view = .init()
        router = .init()
        interactor = .init()
        response = HomeResponse(totalPages: 3,
                                mainResponseItemList: [MainResponseItemList(type: .item,
                                                                            name: "item",
                                                                            homeResponseItemList: [HomeResponseItemList(imageID: 1,
                                                                                                                        id: 2,
                                                                                                                        name: "name")],
                                                                            imageID: 1,
                                                                            id: 2,
                                                                            speed: 4,
                                                                            service: 5,
                                                                            taste: 6,
                                                                            averageScore: 7,
                                                                            deliveryTime: "deliveryTime",
                                                                            categoryName: "categoryName")])
        presenter = .init(view: view,
                          interactor: interactor,
                          router: router,
                          viewWidth: 300)
    }

    func test_numberOfItems_ReturnHomeListCount() {
        presenter.handleHomeResult(.success(response))
        XCTAssertEqual(presenter.numberOfItems, 1)
    }

    func test_item_ReturnMainResponseItemList() {
        presenter.handleHomeResult(.success(response))
        XCTAssertEqual(presenter.item(index: 0)?.averageScore, 7.0)
        XCTAssertEqual(presenter.item(index: 0)?.categoryName, "categoryName")
        XCTAssertEqual(presenter.item(index: 0)?.deliveryTime, "deliveryTime")
        XCTAssertEqual(presenter.item(index: 0)?.imageID, 1)
        XCTAssertEqual(presenter.item(index: 0)?.name, "item")
    }

    func test_sizeForItem_ReturnItemSize() {
        presenter.handleHomeResult(.success(response))
        XCTAssertEqual(presenter.sizeForItem(index: 0).height, 80)
        XCTAssertEqual(presenter.sizeForItem(index: 0).width, 300)
    }

    func test_didSelectRowAt_InvokeNeccessaryMethod() {
        XCTAssertNil(router.invokedNavigateRestaurantParameters)

        presenter.handleHomeResult(.success(response))
        presenter.didSelectRowAt(index: 0)

        XCTAssertEqual(router.invokedNavigateRestaurantParameters?.restaurantId, 2)
    }

    func test_fetchNextPage_ReturnNextPage() {
        XCTAssertNil(interactor.invokedFetchAddressListParameters)

        presenter.handleHomeResult(.success(response))
        presenter.fetchNextPage()

        XCTAssertEqual(interactor.invokedFetchAddressListParameters?.page, 1)
    }
}
