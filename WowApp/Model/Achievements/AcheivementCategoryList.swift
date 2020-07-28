//
//  AcheivementCategoryList.swift
//  WowApp
//
//  Created by Greg Martin on 7/6/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import Foundation

struct AchievementCategoryList: Decodable {
    
    var id: Int?
    var name: String?
    var achievements: [AchievementCategory]
    var subCategories: [AchievementCategory]
    var isGuildCategory: Bool?
    var hordeAggregate: Faction
    var allianceAggregate: Faction
    var displayOrder: Int?
    
    enum CategoryKeys: String, CodingKey {
        case id
        case name
        case achievements
        case subCategories = "subcategories"
        case isGuildCategory = "is_guild_category"
        case aggregatesByFaction = "aggregates_by_faction"
        case alliance = "alliance"
        case horde = "horde"
        case displayOrder = "display_order"
    }
    
    init() {
        id = nil
        name = nil
        achievements = []
        subCategories = []
        isGuildCategory = nil
        allianceAggregate = Faction()
        hordeAggregate = Faction()
        displayOrder = nil
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CategoryKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        achievements = try container.decode([AchievementCategory].self, forKey: .achievements)
        subCategories = try container.decode([AchievementCategory].self, forKey: .subCategories)
        isGuildCategory = try container.decode(Bool.self, forKey: .isGuildCategory)
        
        let factionAggregates = try container.nestedContainer(keyedBy: CategoryKeys.self, forKey: .aggregatesByFaction)
        allianceAggregate = try factionAggregates.decode(Faction.self, forKey: .alliance)
        hordeAggregate = try factionAggregates.decode(Faction.self, forKey: .horde)
        
        displayOrder = try container.decode(Int.self, forKey: .displayOrder)
    }
}
