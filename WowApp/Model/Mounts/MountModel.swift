//
//  MountModel.swift
//  WowApp
//
//  Created by Greg Martin on 7/20/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import Foundation

struct CreatureDisplay: Decodable {
    var id: Int
}

struct MountModel: Decodable {
    var id: Int?
    var name: String
    var creatureDisplays: [CreatureDisplay]
    var description: String
    var sourceName: String
    var factionName: String
    
    var mountDataURL: URL? {
        if let url = createMountURL(mountId: creatureDisplays.first?.id ?? -1) {
            return url
        }
        return nil
    }
    
    enum MountKeys: String, CodingKey {
        case id
        case name
        case creatureDisplays = "creature_displays"
        case description
        case source
        case faction
    }
    
    init() {
        id = nil
        name = ""
        creatureDisplays = []
        description = ""
        sourceName = ""
        factionName = ""
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MountKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        if container.contains(.creatureDisplays) {
            creatureDisplays = try container.decode([CreatureDisplay].self, forKey: .creatureDisplays)
        } else {
            creatureDisplays = []
        }
        description = try container.decode(String.self, forKey: .description)
        
        if container.contains(.source) {
            let sourceContainer = try container.nestedContainer(keyedBy: MountKeys.self, forKey: .source)
            sourceName = try sourceContainer.decode(String.self, forKey: .name)
        } else {
            sourceName = ""
        }
        
        if container.contains(.faction) {
            let factionContainer = try container.nestedContainer(keyedBy: MountKeys.self, forKey: .faction)
            factionName = try factionContainer.decode(String.self, forKey: .name)
        } else {
            factionName = ""
        }
    }
    
    private func createMountURL(mountId: Int) -> URL? {
        if mountId < 0 {
            return nil
        }
        let urlString = "https://render-us.worldofwarcraft.com/npcs/zoom/creature-display-\(mountId).jpg"
        return URL(string: urlString)
    }
}
