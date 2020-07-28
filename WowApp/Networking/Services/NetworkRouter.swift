//
//  NetworkRouter.swift
//  WowApp
//
//  Created by Greg Martin on 6/23/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}
