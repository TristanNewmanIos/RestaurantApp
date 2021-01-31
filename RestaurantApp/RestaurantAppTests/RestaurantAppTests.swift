//
//  RestaurantAppTests.swift
//  RestaurantAppTests
//
//  Created by Tristan Newman on 1/31/21.
//

import XCTest
@testable import RestaurantApp

class RestaurantAppTests: XCTestCase {
    
    var viewModel: RestaurantsViewModel! = RestaurantsViewModel()
    var mockNetworkManager: MockNetworkManager! = MockNetworkManager()

    override class func setUp() {
    }
    
    func testInit() {
        XCTAssertTrue(viewModel.restaurants.isEmpty)
    }
    
    func testGetRestaurants() {
        viewModel.networkManager = mockNetworkManager
        let expectation = self.expectation(description: "getRestaurants")
        
        mockNetworkManager.testGetRestaurants(completion: {
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertTrue(expectation.expectedFulfillmentCount == 1)
    }
    
    func testGetNumberOfRestaurantsNoLoadData() {
        viewModel.restaurants.append(Restaurant(id: 947, name: "Burger Queen", description: "Tasty burgers", category: "burgers"))
        XCTAssertEqual(1, viewModel.getNumberOfRestaurants())
    }
    
    func getRestaurant() {
        let burgerQueen = Restaurant(id: 947, name: "Burger Queen", description: "Tasty burgers", category: "burgers")
        viewModel.restaurants.append(burgerQueen)
        XCTAssertEqual(burgerQueen, viewModel.getRestaurant(byIndex: 0))
    }
    
}
