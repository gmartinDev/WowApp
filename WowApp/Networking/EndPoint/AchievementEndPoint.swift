//
//  wowGameDataEndPoint.swift
//  WowApp
//
//  Created by Greg Martin on 6/23/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import Foundation

public enum AchievementApi {
    case categories
    case category(achievementCategoryId: Int)
    case achievement(achievementId: Int)
    case achievementMedia(achievementId: Int)
}

extension AchievementApi: EndPointType {
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
        case .categories:
            return "achievement-category/index"
        case .category(let achievementCategoryId):
            return "achievement-category/\(achievementCategoryId)"
        case .achievement(let achievementId):
            return "achievement/\(achievementId)"
        case .achievementMedia(let achievementId):
            return "media/achievement/\(achievementId)"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
//        switch self {
//        case .categories, .category, .achievement, .achievementMedia:
            return .requestParameters(bodyParameters: nil, urlParameters: baseURLParameters)
//        default:
//            return .request
//        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
