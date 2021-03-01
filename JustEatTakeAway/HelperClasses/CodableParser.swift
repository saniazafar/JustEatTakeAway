//
//  CodableParser.swift
//  JustEatTakeAway
//
//  Created by sania zafar on 19/02/2021.
//

import Foundation

class CodableParser: NSObject {

    class func parseResponse<T: Decodable>(_ response: Any?, type: T.Type) -> T? {
        var decodedData: T? = nil
        guard let responseAny = response else {
            
            return decodedData
        }
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: responseAny, options: .prettyPrinted)
            do {
                decodedData = try JSONDecoder().decode(T.self, from: jsonData)
            } catch { }
        } catch { }
        
        return decodedData
    }

}
