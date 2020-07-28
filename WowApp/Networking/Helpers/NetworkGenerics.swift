//
//  NetworkGenerics.swift
//  WowApp
//
//  Created by Greg Martin on 7/20/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import Foundation

/// Generic network response handling - Used to reduce amount of reused code
/// - Parameters:
///   - type: The Model that we want to decode the repsonse to
///   - data: Data returned by the network call
///   - response: Response returned by the network call
///   - error: Error returned by the network call
///   - completion: Result type that has either the decode response type based on the generic or an error string
public func genericResponseHandling<T: Decodable>(of type:T.Type,
                                           withData data: Data?,
                                           withResponse response: URLResponse?,
                                           withError error: Error?,
                                           completion: @escaping (NetworkResult<T, String>) -> Void) {
    if error != nil {
        completion(.failure("Please check your network connection."))
    }
    if let response = response as? HTTPURLResponse {
        let result = handleNetworkResponse(response)
        switch result {
        case .success:
            guard let responseData = data else {
                completion(.failure(NetworkResponse.noData.rawValue))
                return
            }
            do {
                let apiResponse = try JSONDecoder().decode(T.self, from: responseData)
                completion(.success(apiResponse))
            } catch {
                completion(.failure(NetworkResponse.unableToDecode.rawValue))
            }
        case .failure(let networkFailureError):
            completion(.failure(networkFailureError))
        }
    }
}

/// Used to convert HTTP Codes to generic error strings
/// - Parameter response: The response from the API call
/// - Returns: Result type that will contain an error string if failed
private func handleNetworkResponse(_ response: HTTPURLResponse) -> HTTPResult<String> {
    switch response.statusCode {
    case 200...299:
        return .success
    case 401...500:
        return .failure(NetworkResponse.authenticationError.rawValue)
    case 501...599:
        return .failure(NetworkResponse.badRequest.rawValue)
    case 600:
        return .failure(NetworkResponse.outdated.rawValue)
    default:
        return .failure(NetworkResponse.failed.rawValue)
    }
}
