//
//  Restaurant.swift
//  JustEatTakeAway
//
//  Created by sania zafar on 19/02/2021.
//

import Foundation

class Restaurant: Codable {
    
    var name: String?
    var status: String?
    var sortingValues: [String: Double]?
    
    enum CodingKeys: String, CodingKey {
        case name
        case status
        case sortingValues
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        status = try values.decodeIfPresent(String.self, forKey: .status) ?? ""
        sortingValues = try values.decodeIfPresent([String: Double].self, forKey: .sortingValues) ?? [:]
    }

}


extension Restaurant: Equatable {
    
    static func == (lhs: Restaurant, rhs: Restaurant) -> Bool {
        
        return lhs.name == rhs.name
    }
    
}
