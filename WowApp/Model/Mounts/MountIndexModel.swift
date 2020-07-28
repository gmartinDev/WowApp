//
//  MountIndexModel.swift
//  WowApp
//
//  Created by Greg Martin on 7/20/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import Foundation

struct MountIndexModel: Decodable {
    var mounts: [BaseModel]
    
    init() {
        mounts = []
    }
}
