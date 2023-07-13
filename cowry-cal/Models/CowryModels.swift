//
//  CowryModels.swift
//  cowry-cal
//
//  Created by Bash on 13/07/2023.
//

import Foundation
import SwiftyJSON

struct CurrencySymbols {
    let success: Bool
    let symbols: [String: String]
    
    init(json: JSON) {
        success = json["success"].boolValue
        symbols = json["symbols"].dictionaryValue.mapValues { $0.stringValue }
    }
}


struct ConversionResponse {
    let success: Bool
    let from: String
    let to: String
    let amount: Double
    let timestamp: TimeInterval
    let rate: Double
    let historical: String
    let date: String
    let result: Double
    
    init(json: JSON) {
        success = json["success"].boolValue
        from = json["query"]["from"].stringValue
        to = json["query"]["to"].stringValue
        amount = json["query"]["amount"].doubleValue
        timestamp = json["info"]["timestamp"].doubleValue
        rate = json["info"]["rate"].doubleValue
        historical = json["historical"].stringValue
        date = json["date"].stringValue
        result = json["result"].doubleValue
    }
}
