//
//  MountsView.swift
//  WowApp
//
//  Created by Greg Martin on 7/20/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import SwiftUI
import URLImage

struct MountsView: View {
    @ObservedObject var mountsVM = MountViewModel()
    
    @State private var selectedCategoryId: Int = -1
    @State private var showModal: Bool = false
    var body: some View {
        NavigationView {
            mountsVM.errorString.map({
                Text($0)
            })
            List(mountsVM.mountsIndexModel.mounts) { mount in
                HStack {
                    Text(mount.name)
                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    self.selectedCategoryId = mount.id
                    self.showModal.toggle()
                }
            }
            .listStyle(GroupedListStyle())
            .sheet(isPresented: $showModal) {
                MountView(mountId: self.selectedCategoryId)
                    .environmentObject(self.mountsVM)
            }
            .navigationBarTitle(Text("Mounts"))
        }
        .onAppear() {
            self.mountsVM.getMountsIndex()
        }.environmentObject(mountsVM)
    }
}

struct MountView: View {
    @EnvironmentObject var mountsVM: MountViewModel
    let mountId: Int
    
    var body: some View {
       VStack {
            if self.mountsVM.mountData.mountDataURL != nil {
                PullURLImageView(imageUrl: self.mountsVM.mountData.mountDataURL!)
            }
            Text("Mount Data here")
            Spacer()
        }
        .padding(.vertical, 20)
        .onAppear() {
            self.mountsVM.getMount(withId: self.mountId)
        }
    }
}

struct MountsView_Previews: PreviewProvider {
    static var previews: some View {
        MountsView()
    }
}
