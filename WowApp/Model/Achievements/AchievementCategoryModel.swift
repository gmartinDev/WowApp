//
//  AchievementCategoryModel.swift
//  WowApp
//
//  Created by Greg Martin on 7/6/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import Foundation

class AchievementCategoryModel: Decodable, Identifiable {
    
    let id: Int
    let name: String
    let href: String?
    var achievements: [AchievementCategoryModel]
    var subCategories: [AchievementCategoryModel]
    let isGuildCategory: Bool?
    let hordeAggregate: Faction
    let allianceAggregate: Faction
    let displayOrder: Int?
    
    var generalCategory: AchievementCategoryModel?
    
    enum CategoryKeys: String, CodingKey {
        case id
        case name
        case key
        case href
        case achievements
        case subCategories = "subcategories"
        case isGuildCategory = "is_guild_category"
        case aggregatesByFaction = "aggregates_by_faction"
        case alliance = "alliance"
        case horde = "horde"
        case displayOrder = "display_order"
    }
    
    init(id: Int = 0, name: String = "", href: String? = nil) {
        self.id = id
        self.name = name
        self.href = href
        achievements = []
        subCategories = []
        isGuildCategory = nil
        allianceAggregate = Faction()
        hordeAggregate = Faction()
        displayOrder = nil
        generalCategory = nil
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CategoryKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        
        if container.contains(.key) {
            let key = try container.nestedContainer(keyedBy: CategoryKeys.self, forKey: .key)
            href = try key.decode(String.self, forKey: .href)
        }  else {
            href = nil
        }
        
        if container.contains(.achievements) {
            achievements = try container.decode([AchievementCategoryModel].self, forKey: .achievements)
        } else {
            achievements = []
        }
        if container.contains(.subCategories) {
            subCategories = try container.decode([AchievementCategoryModel].self, forKey: .subCategories)
        } else {
            subCategories = []
        }
        
        if container.contains(.subCategories) {
            isGuildCategory = try container.decode(Bool.self, forKey: .isGuildCategory)
        } else {
            isGuildCategory = nil
        }
        
        if container.contains(.aggregatesByFaction) {
            let factionAggregates = try container.nestedContainer(keyedBy: CategoryKeys.self, forKey: .aggregatesByFaction)
            allianceAggregate = try factionAggregates.decode(Faction.self, forKey: .alliance)
            hordeAggregate = try factionAggregates.decode(Faction.self, forKey: .horde)
        } else {
            allianceAggregate = Faction()
            hordeAggregate = Faction()
        }
        
        if container.contains(.displayOrder) {
            displayOrder = try container.decode(Int.self, forKey: .displayOrder)
        } else {
            displayOrder = nil
        }
        
        if container.contains(.subCategories) && container.contains(.achievements) {
            generalCategory = AchievementCategoryModel(id: -1, name: "General", href: "")
        }
    }
}
