//
//  ContentView.swift
//  WowApp
//
//  Created by Greg Martin on 6/18/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            AchievementView()
                .tabItem{
                    VStack {
                        Image(systemName: "1.circle")
                        Text("Achievements")
                    }
                }
                .tag(0)
            MountsView()
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "2.circle")
                        Text("Mounts")
                    }
                }
                .tag(1)
            Text("Third View")
            .font(.title)
            .tabItem {
                VStack {
                    Image(systemName: "3.circle")
                    Text("Professions")
                }
            }
            .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
