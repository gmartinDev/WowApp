//
//  BlizzardTokenReponse.swift
//  WowApp
//
//  Created by Greg Martin on 6/18/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import Foundation

public struct BlizzardTokenResponse : Codable {
    public var accessToken: String
    public var tokenType: String
    public var expiresIn: Int
    
    enum CodingKeys: String, CodingKey {
        case accessToken    = "access_token"
        case tokenType      = "token_type"
        case expiresIn      = "expires_in"
    }
    
    public init (from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = try values.decode(String.self, forKey: .accessToken)
        tokenType = try values.decode(String.self, forKey: .tokenType)
        expiresIn = try values.decode(Int.self, forKey: .expiresIn)
    }
}
