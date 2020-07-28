//
//  EndPointType.swift
//  WowApp
//
//  Created by Greg Martin on 6/23/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
