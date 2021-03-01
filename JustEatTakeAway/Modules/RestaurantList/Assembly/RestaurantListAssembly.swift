//
//  RestaurantListAssembly.swift
//  JustEatTakeAway
//
//  Created by sania zafar on 19/02/2021.
//

import UIKit

class RestaurantListAssembly: NSObject, RestaurantListAssemblyProtocol {
    
    
    // MARK: - RestaurantListAssemblyProtocol
    
    func assemblyModule() -> UIViewController {
        
        return self.viewRestaurantListModule()
    }
    
    
    // MARK: - Private
    
    private func viewRestaurantListModule() -> RestaurantListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "RestaurantListViewController") as? RestaurantListViewController
        viewController?.presenter = self.presenterRestaurantListModule(with: viewController)

        return viewController!
    }

    private func presenterRestaurantListModule(with viewController: RestaurantListViewController?) -> RestaurantListPresenter? {
        let presenter = RestaurantListPresenter()
        presenter.userInterface = viewController
        presenter.interactor = interactorRestaurantListModule(with: presenter)

        return presenter
    }
    
    private func interactorRestaurantListModule(with presenter: RestaurantListPresenter?) -> RestaurantListInteractor? {
        let interactor = RestaurantListInteractor()
        interactor.presenter = presenter

        return interactor
    }
    
}
