//
//  RestaurantListInteractor.swift
//  JustEatTakeAway
//
//  Created by sania zafar on 19/02/2021.
//

import Foundation

enum SortPriority: String {
    
    case open = "open"
    case orderAhead = "order ahead"
    case closed = "closed"
    
}

enum SortValue: String {
    
    case bestMatch = "bestMatch"
    case newest = "newest"
    case ratingAverage = "ratingAverage"
    case distance = "distance"
    case popularity = "popularity"
    case averageProductPrice = "averageProductPrice"
    case deliveryCosts = "deliveryCosts"
    case minCost = "minCost"
    
}

class RestaurantListInteractor: NSObject, RestaurantListInteractorInput {
    
    var presenter: RestaurantListInteractorOutput?
    internal var sectionArray: [SortPriority]?
    internal var restaurants: [Restaurant]?
    
    
    override init() {
        super.init()
        self.sectionArray = [.open, .orderAhead, .closed]
        self.restaurants = self.getDataFromFile()
    }
    
    
    // MARK: - RestaurantListInteractorInput
    
    func getRestaurant(at indexPath: IndexPath) -> Restaurant? {
        var restaurantList: [Restaurant]?
        if let sortPriority = self.object(at: indexPath.section) {
            restaurantList = self.filter(for: sortPriority)
        }
        
        return indexPath.row < restaurantList?.count ?? 0 ? restaurantList?[indexPath.row] : nil
    }
    
    func getNumberOfRows(in section: Int) -> Int {
        var restaurantList: [Restaurant]?
        if let sortPriority = self.object(at: section) {
            restaurantList = self.filter(for: sortPriority)
        }
        
        return restaurantList?.count ?? 0
    }
    
    func applySort(_ sortValue: SortValue?) {
        if let validSort = sortValue, !validSort.rawValue.isEmpty {
            let sortedRestaurants = self.restaurants?.sorted { $0.sortingValues?[validSort.rawValue] ?? 0 > $1.sortingValues?[validSort.rawValue] ?? 0 }
            self.restaurants = sortedRestaurants
            self.presenter?.reloadViewContent()
        }
    }
    
    func filterData(by searchText: String, completionBlock: @escaping () -> Void) {
        if !searchText.isEmpty {
            self.restaurants = self.restaurants?.filter { $0.name?.lowercased().contains(searchText.lowercased()) ?? false }
        } else {
            self.restaurants = self.getDataFromFile()
        }
        completionBlock()
    }
    
    
    // MARK: - Private
    
    private func getDataFromFile() -> [Restaurant]? {
        if let jsonResponse = JSONParser.getJSONResponseFromFile("restaurant-list"), let restaurantsArray = jsonResponse["restaurants"] as? [Any] {
            
            return CodableParser.parseResponse(restaurantsArray, type: [Restaurant].self)
        }
        
        return nil
    }
    
    private func object(at index: Int) -> SortPriority? {
        
        return index < self.sectionArray?.count ?? 0 ? self.sectionArray?[index] : nil
    }
    
    private func filter(for sortPriority: SortPriority) -> [Restaurant] {
        
        return self.restaurants?.filter { $0.status == sortPriority.rawValue && UserDefaults.standard.bool(forKey: $0.name ?? "") == false } ?? []
    }
    
}
