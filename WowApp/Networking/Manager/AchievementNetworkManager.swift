//
//  NetworkManager.swift
//  WowApp
//
//  Created by Greg Martin on 6/26/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import Foundation

struct AchievementNetworkManager {
    private let router = Router<AchievementApi>()
    
    /// Gets all Achievement root categories, guild categories and all categories for a searchbar
    /// - Parameter completion: Result type that returns the model or an error string
    func getAchievementCategories(completion: @escaping (NetworkResult<AchievementCategoryIndexModel, String>) -> Void) {
        self.router.request(.categories) { (data, response, error) in
            genericResponseHandling(of: AchievementCategoryIndexModel.self, withData: data, withResponse: response, withError: error) { result in
                completion(result)
            }
        }
        
    }
    
    /// Gets achievements or subcategories for a given Achievement category
    /// - Parameters:
    ///   - category: The category that the user selected
    ///   - completion: Result type that returns the model or an error string
    func getAchievement(fromCategory category: AchievementCategoryModel, completion: @escaping (NetworkResult<AchievementCategoryModel, String>) -> Void) {
        self.router.request(.category(achievementCategoryId: category.id)) {
           (data, response, error) in
            genericResponseHandling(of: AchievementCategoryModel.self, withData: data, withResponse: response, withError: error) { result in
                completion(result)
            }
        }
    }
    
    /// Gets the Achievement that the user selected
    /// - Parameters:
    ///   - id: The ID of the achievement
    ///   - completion: Result type that returns the model or an error string
    func getAchievement(withId id: Int, completion: @escaping (NetworkResult<AchievementModel, String>) -> Void) {
        self.router.request(.achievement(achievementId: id)) {
            (data, response, error) in
            genericResponseHandling(of: AchievementModel.self, withData: data, withResponse: response, withError: error) { result in
                completion(result)
            }
        }
    }
    
    /// Gets any Media associated with a given Achievement
    /// - Parameters:
    ///   - id: The ID of the achievement
    ///   - completion: Result type that returns the model or an error string
    func getAchievementMedia(withId id: Int, completion: @escaping (NetworkResult<AchievementMediaModel, String>) -> Void) {
        self.router.request(.achievementMedia(achievementId: id)) {
            (data, response, error) in
            genericResponseHandling(of: AchievementMediaModel.self, withData: data, withResponse: response, withError: error) { result in
                completion(result)
            }
        }
    }
}

