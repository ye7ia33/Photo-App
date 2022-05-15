//  CodableHandler.swift
//
//  Created by Yahia El-Dow
//  Copyright © 2021 Yahia El-Dow. All rights reserved.
//

import UIKit
import SwiftyJSON

struct CodableHandler {
    static let shared = CodableHandler()
    
    private init() { }
    
    func decode<T : Decodable>(_  type: T.Type , jsonData : JSON) -> Any?{
        let decoder = JSONDecoder()
        let modelClass = try? decoder.decode(type.self, from: jsonData.rawData())
        return modelClass ?? nil
    }
}
