//
//  MountEndPoint.swift
//  WowApp
//
//  Created by Greg Martin on 7/17/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import Foundation

public enum MountsApi {
    case mountsIndex
    case mount(mountId: Int)
    case mountMedia(creatureDisplayId: Int)
}

extension MountsApi: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: "https://us.api.blizzard.com/data/wow/") else { fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var baseURLParameters: [String:String] {
        let region = "us"
        let namespace = "static-us"
        let locale = "en_US"
        return ["region":region,
                "namespace":namespace,
                "locale": locale
        ]
    }
    
    var path: String {
        switch self {
        case .mountsIndex:
            return "mount/index"
        case .mount(let mountId):
            return "mount/\(mountId)"
        case .mountMedia(let creatureDisplayId):
            return "media/creature-display/\(creatureDisplayId)"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        return .requestParameters(bodyParameters: nil, urlParameters: baseURLParameters)
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
