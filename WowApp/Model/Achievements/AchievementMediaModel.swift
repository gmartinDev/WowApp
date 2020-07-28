//
//  AchievementMediaModel.swift
//  WowApp
//
//  Created by Greg Martin on 7/13/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import Foundation

struct Asset {
    var key: String
    var value: String
    var assetURL: URL?
}

extension Asset: Decodable {
    enum CategoryKeys: CodingKey {
        case key
        case value
    }

    init() {
        key = ""
        value = ""
        assetURL = nil
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CategoryKeys.self)
        key = (try? container.decode(String.self, forKey: .key)) ?? ""
        value = (try? container.decode(String.self, forKey: .value)) ?? ""
        assetURL = URL(string: value)
    }
}

struct AchievementMediaModel: Decodable {
    let id: Int?
    let assets: [Asset]?
    
    init() {
        id = nil
        assets = nil
    }
}
