//
//  NetworkManager.swift
//  RestaurantApp
//
//  Created by Tristan Newman on 1/31/21.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let defaultSession = URLSession.shared
    private let decoder = JSONDecoder()

    func getRestaurants(completion: @escaping(Swift.Result<[Restaurant], AppError>) -> Void) {
        var request = URLRequest(url: URL(string: "https://www.json-generator.com/api/json/get/bQwCjWxBDS")!)
        request.httpMethod = "GET"
        let task = defaultSession.dataTask(with: request) { [unowned self] data, urlResponse, error in
            DispatchQueue.main.async { [unowned self] in
                if let error = error {
                    completion(.failure(AppError(error)))
                } else if let data = data,
                    let urlResponse = urlResponse as? HTTPURLResponse,
                    urlResponse.statusCode == 200 {
                    do {
                        let parsedData = try self.decoder.decode([Restaurant].self, from: data)
                        completion(.success(parsedData))
                    } catch {
                        completion(.failure(AppError(error)))
                    }
                } else {
                    let appError = AppError(code: 404,
                                          message: "Sorry, we are unable to connect to the server at this moment")
                    completion(.failure(appError))
                }
            }
        }
        task.resume()
    }
}
