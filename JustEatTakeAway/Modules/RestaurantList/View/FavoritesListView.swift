//
//  FavoritesListView.swift
//  JustEatTakeAway
//
//  Created by sania zafar on 28/02/2021.
//

import UIKit

class FavoritesListView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var tableView: UITableView!
    
    static let identifier = "FavoritesListView"
    private var favoritesList: [Restaurant]?
    private var selectedSort = SortValue.distance
    weak var delegate: RestaurantListTableViewCellDelegate?
    let sectionArray: [SortPriority] = [.open, .orderAhead, .closed]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupTableView()
    }
    
    
    // MARK: - Public
    
    func configureView(_ favorites: [Restaurant]?, selectedSort: SortValue) {
        self.favoritesList = favorites
        self.selectedSort = selectedSort
    }
    
    func reloadContentView() {
        self.tableView.reloadData()
    }
    
}


// MARK: - Private

private extension FavoritesListView {
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "RestaurantListTableViewCell", bundle: nil), forCellReuseIdentifier: RestaurantListTableViewCell.identifier)
    }
    
    func getRestaurant(at indexPath: IndexPath) -> Restaurant? {
        var restaurantList: [Restaurant]?
        if let sortPriority = self.object(at: indexPath.section) {
            restaurantList = self.favoritesList?.filter { $0.status == sortPriority.rawValue }
        }
        
        return indexPath.row < restaurantList?.count ?? 0 ? restaurantList?[indexPath.row] : nil
    }
    
    func getNumberOfRows(in section: Int) -> Int {
        var restaurantList: [Restaurant]?
        if let sortPriority = self.object(at: section) {
            restaurantList = self.favoritesList?.filter { $0.status == sortPriority.rawValue }
        }
        
        return restaurantList?.count ?? 0
    }
    
    func object(at index: Int) -> SortPriority? {
        
        return index < self.sectionArray.count ? self.sectionArray[index] : nil
    }
    
}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension FavoritesListView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.getNumberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 115.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let restaurantCell = tableView.dequeueReusableCell(withIdentifier: RestaurantListTableViewCell.identifier) as? RestaurantListTableViewCell,
           let restaurant = self.getRestaurant(at: indexPath) {
            restaurantCell.delegate = self.delegate
            restaurantCell.configureCell(with: restaurant, selectedSort: self.selectedSort)
            cell = restaurantCell
        }
        
        return cell
    }
    
}
