//
//  AchievementCriteriaModel.swift
//  WowApp
//
//  Created by Greg Martin on 7/20/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import Foundation

struct ChildCriteriaModel: Decodable, Identifiable {
    let id: Int
    let description: String
    let amount: Int
    let achievement: BaseModel?
    
    enum ChildCriteriaKeys: String, CodingKey {
        case id
        case description
        case amount
        case achievement
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ChildCriteriaKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        description = try container.decode(String.self, forKey: .description)
        amount = try container.decode(Int.self, forKey: .amount)
        achievement = try container.decode(BaseModel.self, forKey: .achievement)
    }
}

struct AchievementCriteriaModel: Decodable, Identifiable {
    let id: Int
    let description: String
    let amount: Int
    let childCriteria: [ChildCriteriaModel]?
    
    enum CriteriaKeys: String, CodingKey {
        case id
        case description
        case amount
        case childCriteria = "child_criteria"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CriteriaKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        description = try container.decode(String.self, forKey: .description)
        amount = try container.decode(Int.self, forKey: .amount)
        if container.contains(.childCriteria) {
            childCriteria = try container.decode([ChildCriteriaModel].self, forKey: .childCriteria)
        } else {
            childCriteria = nil
        }
    }
}
