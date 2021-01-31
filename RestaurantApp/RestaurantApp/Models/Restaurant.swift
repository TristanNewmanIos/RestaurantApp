//
//  Restaurant.swift
//  RestaurantApp
//
//  Created by Tristan Newman on 1/31/21.
//

import Foundation

struct Restaurant: Decodable, Equatable {
    static func == (lhs: Restaurant, rhs: Restaurant) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: Int
    let name: String?
    let description: String?
    let category: String?
}
