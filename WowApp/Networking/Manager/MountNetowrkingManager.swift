//
//  MountNetowrkingManager.swift
//  WowApp
//
//  Created by Greg Martin on 7/17/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import Foundation

struct MountNetworkingManager {
    private let router = Router<MountsApi>()
    
    
    /// Gets a list of all mounts
    /// - Parameter completion: Result type that returns the mounts model or an error string
    func getMountsIndex(completion: @escaping (NetworkResult<MountIndexModel, String>) -> Void) {
        self.router.request(.mountsIndex) { (data, response, error) in
            genericResponseHandling(of: MountIndexModel.self, withData: data, withResponse: response, withError: error) { result in
                completion(result)
            }
        }
    }
    
    func getMount(withId id: Int, completion: @escaping (NetworkResult<MountModel, String>) -> Void) {
        self.router.request(.mount(mountId: id)) { (data, response, error) in
            genericResponseHandling(of:MountModel.self ,withData: data, withResponse: response, withError: error) { (result) in
                completion(result)
//                switch result {
//                case .success(let data):
//                    completion(.success(data))
//                case .failure(let errorString):
//                    completion(.failure(errorString))
//                }
            }
        }
    }
}
