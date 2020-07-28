//
//  AchievementModel.swift
//  WowApp
//
//  Created by Greg Martin on 7/10/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import Foundation

struct MediaModel: Decodable {
    let href: String
    let id: Int
    
    enum CategoryKeys: CodingKey {
        case id
        case key
        case href
    }
    
    init() {
        href = ""
        id = -1
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CategoryKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        
        let key = try container.nestedContainer(keyedBy: CategoryKeys.self, forKey: .key)
        href = try key.decode(String.self, forKey: .href)
    }
}

struct AchievementModel: Decodable {
    var id: Int?
    var name: String
    var category: AchievementCategoryModel?
    var description: String
    var points: Int?
    var isAccountWide: Bool?
    var criteria: AchievementCriteriaModel?
    var nextAchievement: AchievementCategoryModel?
    var rewardDescription: String?
    var rewardItem: BaseModel?
    var media: MediaModel?
    var displayOrder: Int?
    
    var containsChildCriteria: Bool {
        if criteria != nil && criteria?.childCriteria != nil && (criteria?.childCriteria?.count ?? 0) > 0 {
            return true
        }
        return false
    }
    
    enum CategoryKeys: String, CodingKey {
        case id
        case name
        case key
        case category
        case description
        case points
        case isAccountWide = "is_account_wide"
        case criteria
        case nextAchievement = "next_achievement"
        case rewardDescription = "reward_description"
        case rewardItem = "reward_item"
        case media
        case displayOrder = "display_order"
    }
    
    init() {
        id = nil
        name = ""
        category = nil
        description = ""
        points = nil
        isAccountWide = nil
        criteria = nil
        nextAchievement = nil
        rewardDescription = nil
        rewardItem = nil
        media = nil
        displayOrder = nil
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CategoryKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        
        category = try container.decode(AchievementCategoryModel.self, forKey: .category)
        description = try container.decode(String.self, forKey: .description)
        points = try container.decode(Int.self, forKey: .points)
        isAccountWide = try container.decode(Bool.self, forKey: .isAccountWide)
        criteria = try container.decode(AchievementCriteriaModel.self, forKey: .criteria)
        if container.contains(.nextAchievement) {
            nextAchievement = try container.decode(AchievementCategoryModel.self, forKey: .nextAchievement)
        } else {
            nextAchievement = nil
        }
        if container.contains(.rewardDescription) {
            rewardDescription = try container.decode(String.self, forKey: .rewardDescription)
        } else {
            rewardDescription = nil
        }
        if container.contains(.rewardItem) {
            rewardItem = try container.decode(BaseModel.self, forKey: .rewardItem)
        } else {
            rewardItem = nil
        }
        media = try container.decode(MediaModel.self, forKey: .media)
        displayOrder = try container.decode(Int.self, forKey: .displayOrder)
    }
}
