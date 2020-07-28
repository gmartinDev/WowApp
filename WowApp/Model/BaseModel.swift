//
//  AchievementCategory.swift
//  WowApp
//
//  Created by Greg Martin on 6/26/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import Foundation

struct BaseModel {
    let id: Int
    let name: String
    let href: String
}

extension BaseModel: Decodable, Identifiable {
    enum CategoryKeys: CodingKey {
        case id
        case name
        case key
        case href
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CategoryKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        
        let key = try container.nestedContainer(keyedBy: CategoryKeys.self, forKey: .key)
    
        href = try key.decode(String.self, forKey: .href)
    }
}
