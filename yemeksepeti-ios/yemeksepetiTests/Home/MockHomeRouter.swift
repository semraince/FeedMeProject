//
//  MockHomeRouter.swift
//  yemeksepetiTests
//
//  Created by semra on 22.08.2021.
//

@testable import yemeksepeti
import XCTest

final class MockHomeRouter: HomeRouterInterface {
    var invokedNavigateRestaurant = false
    var invokedNavigateRestaurantCount = 0
    var invokedNavigateRestaurantParameters: (restaurantId: Int, Void)?
    var invokedNavigateRestaurantParametersList = [(restaurantId: Int, Void)]()

    func navigateRestaurant(by restaurantId : Int) {
        invokedNavigateRestaurant = true
        invokedNavigateRestaurantCount += 1
        invokedNavigateRestaurantParameters = (restaurantId, ())
        invokedNavigateRestaurantParametersList.append((restaurantId, ()))
    }

    var invokedNavigateCategory = false
    var invokedNavigateCategoryCount = 0
    var invokedNavigateCategoryParameters: (categoryId: Int, Void)?
    var invokedNavigateCategoryParametersList = [(categoryId: Int, Void)]()

    func navigateCategory(by categoryId: Int) {
        invokedNavigateCategory = true
        invokedNavigateCategoryCount += 1
        invokedNavigateCategoryParameters = (categoryId, ())
        invokedNavigateCategoryParametersList.append((categoryId, ()))
    }
}
