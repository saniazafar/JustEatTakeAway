//
//  JSONParser.swift
//  JustEatTakeAway
//
//  Created by sania zafar on 19/02/2021.
//

import Foundation

class JSONParser: NSObject {
    
    static func getJSONResponseFromFile(_ fileName: String) -> NSDictionary? {
        let fixturesBundle = Bundle(for: JSONParser.classForCoder())
        if let filepath = fixturesBundle.path(forResource: fileName, ofType: "json") {
            do {
                let jsonData = try NSData.init(contentsOfFile: filepath, options: .uncached)
                if let jsonObject = jsonData as Data?,
                    let responseDictionary = try JSONSerialization.jsonObject(with: jsonObject, options: .mutableContainers) as? NSDictionary {
                    
                    return responseDictionary
                }
            } catch {
                
                return nil
            }
        }
        
        return nil
    }
    
}
