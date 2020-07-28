//
//  MountViewModel.swift
//  WowApp
//
//  Created by Greg Martin on 7/22/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import Foundation

class MountViewModel: ObservableObject {
    private let networkManager = MountNetworkingManager()
    
    @Published var mountsIndexModel = MountIndexModel()
    @Published var mountData = MountModel()
    @Published var errorString: String? = nil
    
    func getMountsIndex() {
        networkManager.getMountsIndex() { [weak self] (result) in
            switch result {
            case .success(let mountsIndex):
                DispatchQueue.main.async {
                    self?.mountsIndexModel = mountsIndex
                    self?.errorString = nil
                }
            case .failure(let errorString):
                DispatchQueue.main.async {
                    self?.mountsIndexModel.mounts = []
                    self?.errorString = errorString
                }
            }
        }
    }
    
    func getMount(withId id: Int) {
        networkManager.getMount(withId: id) { [weak self] (result) in
            switch result {
            case .success(let mount):
                DispatchQueue.main.async {
                    self?.mountData = mount
                    self?.errorString = nil
                }
            case .failure(let errorString):
                DispatchQueue.main.async {
                    self?.mountData = MountModel()
                    self?.errorString = errorString
                }
            }
        }
    }
    
    func getMountMedia(withId mountId: Int) {
        
    }
}
