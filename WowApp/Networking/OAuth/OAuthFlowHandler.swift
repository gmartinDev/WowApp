//
//  OAuthFlowHandler.swift
//  WowApp
//
//  Created by Greg Martin on 6/18/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import Foundation

public class OAuthFlowHandler {
    private let clientID: String = "979b117e8a074d70829f2c5d1a81bcc4"
    private let clientSecret: String = "kIeUGuKf4VS6N4c02c506AaUHop7mCJp"
    private let authroizeURL: String = "https://us.battle.net/oauth/authorize"
    private let tokenURL: String = "https://us.battle.net/oauth/token"
    private let callbackURI: String = "oauth-swift://oauth-callback/blizzard"
    
    typealias CompletionHandler = (_ token: String) -> Void
    
    private var token: String?
    private var tokenExpiry: Date?
    
    public func getAuthToken(_ completion: @escaping (_ token: String) -> Void) {
        getOrRequestAuthToken(completion)
    }
    
    private func getOrRequestAuthToken(_ completion: @escaping (_ token: String) -> Void) {
        if (isTokenInvalid()) {
            if let url = URL(string: tokenURL) {
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = HTTPMethod.post.rawValue
                urlRequest.httpBody = getRequestData()
                let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
                    if error != nil {
                        print(error?.localizedDescription as Any)
                    } else {
                        let decoder = JSONDecoder()
                        do {
                            let tokenObj = try decoder.decode(BlizzardTokenResponse.self, from: data!)
                            self?.token = tokenObj.accessToken
                            self?.tokenExpiry = Date(timeIntervalSinceNow: TimeInterval(tokenObj.expiresIn))
                            completion(tokenObj.accessToken)
                        } catch let parseError {
                            print("JSON Error \(parseError.localizedDescription)")
                            completion("")
                        }
                    }
                }
                task.resume()
            }
        } else {
            guard let authToken = token  else {
                completion("")
                return
            }
            print(authToken)
            completion(authToken)
        }

    }
    
    private func getRequestData() -> Data {
        let postData = NSMutableData(data: "grant_type=client_credentials".data(using: String.Encoding.utf8)!)
        postData.append("&client_id=\(clientID)".data(using: String.Encoding.utf8)!)
        postData.append("&client_secret=\(clientSecret)".data(using: String.Encoding.utf8)!)
        
        return postData as Data
    }
    
    private func isTokenInvalid() -> Bool {
        guard let _ = token, let expiry = tokenExpiry else {
            return true
        }
        
        return Date() > expiry
    }
}
