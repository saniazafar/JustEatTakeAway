//
//  JustEatTakeAwayTests.swift
//  JustEatTakeAwayTests
//
//  Created by sania zafar on 19/02/2021.
//

import XCTest
@testable import JustEatTakeAway

class JustEatTakeAwayTests: XCTestCase {
    
    var interactor: RestaurantListInteractor?

    override func setUpWithError() throws {
        interactor = RestaurantListInteractor()
    }

    override func tearDownWithError() throws {
        interactor = nil
    }

    func testRestaurantListCount() throws {
        XCTAssertEqual(interactor?.restaurants?.count, 19)
    }
    
    func testRestaurantEmptyList() throws {
        XCTAssertFalse(interactor?.restaurants?.count == 0)
    }

    func testApplySortForBestMatch() throws {
        if let jsonResponse = JSONParser.getJSONResponseFromFile("mock-response-best-match-sorted"),
           let restaurantsArray = jsonResponse["restaurants"] as? [Any] {
            let sortedList = CodableParser.parseResponse(restaurantsArray, type: [Restaurant].self)
            interactor?.applySort(SortValue.bestMatch)
            
            XCTAssertEqual(sortedList, interactor?.restaurants)
        }
    }

}
