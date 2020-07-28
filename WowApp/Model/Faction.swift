//
//  FactionAggregates.swift
//  WowApp
//
//  Created by Greg Martin on 7/6/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import Foundation

struct Faction: Codable {
    let quantity: Int?
    let points: Int?
    
    init(quantity: Int? = nil, points: Int? = nil) {
        self.quantity = quantity
        self.points = points
    }
}
