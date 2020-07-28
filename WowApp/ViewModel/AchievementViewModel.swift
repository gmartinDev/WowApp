//
//  AchievementViewModel.swift
//  WowApp
//
//  Created by Greg Martin on 6/29/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import Foundation

class AchievementViewModel: ObservableObject {
    private let networkManager = AchievementNetworkManager()
    
    @Published var achievementList = AchievementCategoryIndexModel()
    @Published var achievementCategories = AchievementCategoryModel()
    @Published var achievementData = AchievementModel()
    @Published var achievementMedia = AchievementMediaModel()
    @Published var errorString: String? = nil
    
    public func getAchievementCategoriesIndex() {
        networkManager.getAchievementCategories() { [weak self] result in
            switch result {
            case .success(let categoryIndexModel):
                DispatchQueue.main.async {
                    self?.errorString = nil
                    self?.achievementList = categoryIndexModel
                }
            case .failure(let errorString):
                DispatchQueue.main.async {
                    self?.errorString = errorString
                    self?.achievementList.categories = []
                }
            }
        }
    }
    
    public func getAchievement(fromCategory category: AchievementCategoryModel) {
        networkManager.getAchievement(fromCategory:category) { [weak self] result in
            switch result {
            case .success(let categoryModel):
                DispatchQueue.main.async {
                    self?.errorString = nil
                    self?.achievementCategories = categoryModel
                }
            case .failure(let errorString):
                DispatchQueue.main.async {
                    self?.errorString = errorString
                    self?.achievementCategories.achievements = []
                    self?.achievementCategories.subCategories = []
                }
            }
        }
    }
    
    public func getAchievement(withId id: Int) {
        networkManager.getAchievement(withId: id) { [weak self] result in
            switch result {
            case .success(let achievementModel):
                DispatchQueue.main.async {
                    self?.errorString = nil
                    self?.achievementData = achievementModel
                }
            case .failure(let errorString):
                DispatchQueue.main.async {
                    self?.errorString = errorString
                    self?.achievementData = AchievementModel()
                }
            }
        }
    }
    
    public func getAchievementMedia(withId id: Int) {
        networkManager.getAchievementMedia(withId: id) { [weak self] result in
            switch result {
            case .success(let achievementMediaModel):
                DispatchQueue.main.async {
                    self?.errorString = nil
                    self?.achievementMedia = achievementMediaModel
                }
            case .failure(let errorString):
                DispatchQueue.main.async {
                    self?.errorString = errorString
                    self?.achievementMedia = AchievementMediaModel()
                }
            }
        }
    }
}
