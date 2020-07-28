//
//  AchievementView.swift
//  WowApp
//
//  Created by Greg Martin on 6/29/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import Foundation
import SwiftUI

//View for achievement index list
struct AchievementView: View {
    @ObservedObject var achievementVM = AchievementViewModel()

    var body: some View {
        NavigationView {
            achievementVM.errorString.map({
                Text($0)
            })
            List(achievementVM.achievementList.rootCategories) { category in
                genericRow(category: category, nextView: AchievementCategories(parentCategory: category))
            }.listStyle(GroupedListStyle())
            .navigationBarTitle(Text("Achievements"))
        }.onAppear {
            self.achievementVM.getAchievementCategoriesIndex()
        }.environmentObject(achievementVM)
    }
}

private struct AchievementCategories: View {
    @EnvironmentObject var achievementVM: AchievementViewModel
    
    let parentCategory: AchievementCategoryModel
    
    var body: some View {
        VStack {
            achievementVM.errorString.map({
                Text($0)
            })
            List {
                if (!achievementVM.achievementCategories.subCategories.isEmpty) {
                    if (!achievementVM.achievementCategories.achievements.isEmpty && achievementVM.achievementCategories.generalCategory != nil) {
                        genericRow(category: achievementVM.achievementCategories.generalCategory!, nextView: GeneralAchievements())
                    }
                    ForEach( achievementVM.achievementCategories.subCategories) { subCat in
                        genericRow(category: subCat, nextView: AchievementCategories(parentCategory: subCat))
                    }
                } else {
                    ForEach (achievementVM.achievementCategories.achievements) { achievement in
                        AchievementRow(category: achievement)
                    }
                }
            }.listStyle(GroupedListStyle())
            Spacer()
        }
        .navigationBarTitle(Text(parentCategory.name))
        .onAppear {
            if(self.parentCategory.id > 0) {
                self.achievementVM.getAchievement(fromCategory: self.parentCategory)
            }
        }
    }
}

private struct genericRow<TargetView: View>: View {
    let category: AchievementCategoryModel
    let nextView: TargetView
    
    var body: some View {
        HStack {
            Spacer()
            NavigationLink(destination: nextView) {
                Text(category.name)
            }
            Spacer()
        }
    }
}

private struct GeneralAchievements: View {
    @EnvironmentObject var achievementVM: AchievementViewModel
    @State private var selectedCategoryId: Int = -1
    @State private var showModal: Bool = false
    var body: some View {
        VStack {
            List (achievementVM.achievementCategories.achievements) { achievement in
                HStack {
                    Text(achievement.name)
                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    self.selectedCategoryId = achievement.id
                    self.showModal.toggle()
                }
            }
            .listStyle(GroupedListStyle())
            .sheet(isPresented: $showModal) {
                AchievementDisplay(categoryId: self.selectedCategoryId)
                    .environmentObject(self.achievementVM)
            }
        }
        .navigationBarTitle(Text(achievementVM.achievementCategories.generalCategory?.name ?? ""))
    }
}

private struct AchievementRow: View {
    let category: AchievementCategoryModel
    
    @EnvironmentObject var achievementVM: AchievementViewModel
    @State private var showModal: Bool = false
    
    var body: some View {
        HStack {
            Text(category.name)
            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            self.showModal.toggle()
        }
        .sheet(isPresented: $showModal) {
            AchievementDisplay(categoryId: self.category.id)
            .environmentObject(self.achievementVM)
        }
//        .background(Color.white)
    }
}

private struct AchievementDisplay: View {
    @EnvironmentObject var achievementVM: AchievementViewModel
    let categoryId: Int
    
    var body: some View {
        VStack (spacing: 20) {
            if (achievementVM.achievementMedia.assets?.first?.assetURL != nil) {
                CircularURLImageView(imageURL: (achievementVM.achievementMedia.assets?.first?.assetURL)!)
            } else {
                CircularImageView(imageName: "placeholderImage")
            }
            if (achievementVM.achievementData.isAccountWide != nil) {
                Divider()
                HStack {
                    Text("Account Wide:")
                        .font(.headline)
                    Text("\(achievementVM.achievementData.isAccountWide! ? "Yes" : "No")")
                }
            }
            Divider()
            Text("Description:")
                .font(.headline)
            Text("\(achievementVM.achievementData.description)")
            Spacer()
            if (achievementVM.achievementData.containsChildCriteria) {
                Text("Required Achievements:")
                    .font(.headline)
                HStack {
                    Spacer(minLength: 10)
                    List(achievementVM.achievementData.criteria!.childCriteria!) { criteria in
                        HStack {
                            Text(criteria.description)
                            Spacer()
                        }
                    }
//                    .border(Color.gray, width: 2.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15.0)
                            .stroke(Color.gray, lineWidth: 2.0)
                    )
                    Spacer(minLength: 10)
                }
            }
            if (achievementVM.achievementData.rewardDescription != nil) {
                Text(achievementVM.achievementData.rewardDescription ?? "")
                    .font(.headline)
            }
        }
        .padding(.init(top: 25, leading: 0, bottom: 25, trailing: 0))
        .navigationBarTitle(Text(achievementVM.achievementData.name), displayMode: .inline)
        .onAppear {
            self.achievementVM.getAchievementMedia(withId: self.categoryId)
            self.achievementVM.getAchievement(withId: self.categoryId)
        }
    }
}


// MARK: PREVIEW

struct AchievementView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementView()
    }
}
