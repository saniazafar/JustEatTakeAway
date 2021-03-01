//
//  RestaurantListPresenterIO.swift
//  JustEatTakeAway
//
//  Created by sania zafar on 19/02/2021.
//

import Foundation

protocol RestaurantListPresenterInput: NSObject {
    
    var restaurants: [Restaurant]? { get }
    var sectionArray: [SortPriority]? { get }
    
    func getRestaurant(at indexPath: IndexPath) -> Restaurant?
    func getNumberOfRows(in section: Int) -> Int
    func applySort(_ sortValue: SortValue?)
    func eventSearchBarTextDidChange(_ searchText: String)
    
}

protocol RestaurantListPresenterOutput: NSObject {
    
    func reloadViewContent()
    
}
