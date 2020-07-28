//
//  NetworkingEnums.swift
//  WowApp
//
//  Created by Greg Martin on 7/17/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import Foundation

public enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad Request"
    case outdated = "The URL your requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

/// Used for HTTPRespoonse decoding
public enum HTTPResult<String> {
    case success
    case failure(String)
}

/// Used for Network API calls
public enum NetworkResult<T, String> {
    case success(T)
    case failure(String)
}
