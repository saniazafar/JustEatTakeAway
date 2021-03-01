//
//  RestaurantListPresenter.swift
//  JustEatTakeAway
//
//  Created by sania zafar on 19/02/2021.
//

import Foundation

class RestaurantListPresenter: NSObject, RestaurantListPresenterInput, RestaurantListInteractorOutput {
    
    var interactor: RestaurantListInteractorInput?
    weak var userInterface: RestaurantListPresenterOutput?
    
    var restaurants: [Restaurant]? {
        get {
            
            return self.interactor?.restaurants
        }
    }
    
    var sectionArray: [SortPriority]? {
        get {
            
            return self.interactor?.sectionArray
        }
    }
    
    
    // MARK: - RestaurantListPresenterInput
    
    func getRestaurant(at indexPath: IndexPath) -> Restaurant? {
        
        self.interactor?.getRestaurant(at: indexPath)
    }
    
    func getNumberOfRows(in section: Int) -> Int {
        
        self.interactor?.getNumberOfRows(in: section) ?? 0
    }
    
    func applySort(_ sortValue: SortValue?) {
        self.interactor?.applySort(sortValue)
    }
    
    func eventSearchBarTextDidChange(_ searchText: String) {
        self.interactor?.filterData(by: searchText, completionBlock: {
            self.reloadViewContent()
        })
    }
    
    
    // MARK: - RestaurantListInteractorOutput
    
    func reloadViewContent() {
        self.userInterface?.reloadViewContent()
    }
    
}
