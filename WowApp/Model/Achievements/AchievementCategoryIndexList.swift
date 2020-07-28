//
//  AchievementCategoryIndexList.swift
//  WowApp
//
//  Created by Greg Martin on 7/6/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import Foundation

struct AchievementCategoryIndexModel: Decodable {
    var categories: [AchievementCategoryModel]
    var rootCategories: [AchievementCategoryModel]
    var guildCategories: [AchievementCategoryModel]
    
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
        
        categories = try container.decode([AchievementCategoryModel].self, forKey: .categories)
        rootCategories = try container.decode([AchievementCategoryModel].self, forKey: .rootCategories)
        guildCategories = try container.decode([AchievementCategoryModel].self, forKey: .guildCategories)
    }
}
