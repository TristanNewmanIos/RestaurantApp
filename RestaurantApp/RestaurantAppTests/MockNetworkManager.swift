//
//  MockNetworkManager.swift
//  RestaurantAppTests
//
//  Created by Tristan Newman on 1/31/21.
//

import XCTest
@testable import RestaurantApp

class MockNetworkManager: NetworkManager {
    
    func testGetRestaurants(completion: @escaping() -> Void) {
        getRestaurants(completion: { result in
            completion()
        })
    }
}
