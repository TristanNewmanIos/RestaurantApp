//
//  AppError.swift
//  RestaurantApp
//
//  Created by Tristan Newman on 1/31/21.
//

import Foundation

struct AppError: Error {
    let code: Int?
    let message: String?

    init(_ error: Error) {
        message = error.localizedDescription
        code = nil
    }

    init(code: Int?, message: String?) {
        self.code = code
        self.message = message
    }
}
