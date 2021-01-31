//
//  RestaurantsViewModel.swift
//  RestaurantApp
//
//  Created by Tristan Newman on 1/31/21.
//

import Foundation

protocol RestaurantsViewModelDelegate: AnyObject {
    func restaurantsViewModel(viewModel: RestaurantsViewModel, didLoadData data: [Restaurant])
    func restaurantsViewModel(viewModel: RestaurantsViewModel, failedLoadData error: AppError)
}

class RestaurantsViewModel: NSObject {
    var restaurants: [Restaurant] = []
    var networkManager = NetworkManager()
    weak var delegate: RestaurantsViewModelDelegate?

    override init() {
        super.init()
    }

    func getNumberOfRestaurants() -> Int {
        return restaurants.count
    }

    func getRestaurant(byIndex index: Int) -> Restaurant {
        return restaurants[index]
    }

    func loadData() {
        networkManager.getRestaurants { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.restaurants = data
                self.delegate?.restaurantsViewModel(viewModel: self, didLoadData: data)
            case .failure(let error):
                self.delegate?.restaurantsViewModel(viewModel: self, failedLoadData: error)
            }
        }
    }
}
