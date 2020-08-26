//
//  CodableObject.swift
//  BelanjaQ
//
//  Created by RenhardJH on 24/08/20.
//  Copyright © 2020 RenhardJH. All rights reserved.
//

import Foundation

struct CodableObject {
    
    static func decodeToObject<T>(type: T.Type, data: String) -> T? where T : Decodable {
        let decoder = JSONDecoder()
        do {
        let user = try
            decoder.decode(type, from: data.data(using: .utf8)!)
            return user
        }
        catch let err {
            print("decodeToObject \(err)")
        }
        return nil
    }
    
    static func encodeToString<T>(value: T) -> String where T : Encodable {
        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(value)
        return String(data: jsonData, encoding: .utf8)!
    }
    
}
