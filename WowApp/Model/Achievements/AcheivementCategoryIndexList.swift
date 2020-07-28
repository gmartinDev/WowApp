//
//  AcheivementCategoryIndexList.swift
//  WowApp
//
//  Created by Greg Martin on 7/6/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import Foundation

struct AchievementCategoryIndexList: Decodable {
    var categories: [AchievementCategory]
    var rootCategories: [AchievementCategory]
    var guildCategories: [AchievementCategory]
    
    enum CategoryKeys: String, CodingKey {
        case categories
        case rootCategories = "root_categories"
        case guildCategories = "guild_categories"
    }
    
    init() {
        categories = []
        rootCategories = []
        guildCategories = []
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CategoryKeys.self)
        
        categories = try container.decode([AchievementCategory].self, forKey: .categories)
        rootCategories = try container.decode([AchievementCategory].self, forKey: .rootCategories)
        guildCategories = try container.decode([AchievementCategory].self, forKey: .guildCategories)
    }
}
