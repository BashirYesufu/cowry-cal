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
    let error: ConvError?
    
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
        error = ConvError(json: json["error"])
    }
}

struct ConvError {
    let type: String?
    let info: String?
    let code: Int?
    
    init(json: JSON) {
        type = json["type"].stringValue
        info = json["info"].stringValue
        code = json["code"].intValue
    }
}

struct FluctuationRateResponse {
    let success: Bool
    let timeseries: Bool
    let startDate: String
    let endDate: String
    let base: String
    let rates: [String: Rate]
    let error: ConvError?
    
    struct Rate {
        let usd: Double
        let aud: Double
        let cad: Double
    }
    
    init(json: JSON) {
        success = json["success"].boolValue
        timeseries = json["timeseries"].boolValue
        startDate = json["start_date"].stringValue
        endDate = json["end_date"].stringValue
        base = json["base"].stringValue
        
        var rateDict: [String: Rate] = [:]
        if let ratesJSON = json["rates"].dictionary {
            for (date, rateJSON) in ratesJSON {
                let usd = rateJSON["USD"].doubleValue
                let aud = rateJSON["AUD"].doubleValue
                let cad = rateJSON["CAD"].doubleValue
                
                let rate = Rate(usd: usd, aud: aud, cad: cad)
                rateDict[date] = rate
            }
        }
        
        rates = rateDict
        error = ConvError(json: json["error"])
    }
}
