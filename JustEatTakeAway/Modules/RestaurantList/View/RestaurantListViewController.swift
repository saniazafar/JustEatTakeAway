//
//  RestaurantListViewController.swift
//  JustEatTakeAway
//
//  Created by sania zafar on 19/02/2021.
//

import UIKit

class RestaurantListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var presenter: RestaurantListPresenterInput?
    private var favoritesView: FavoritesListView?
    private var selectedSort = SortValue.distance
    
    
    // MARK: - View Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.configureTableView()
    }
    
    
    // MARK: - Private
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = .systemOrange
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.title = "Just Eat Takeaway"
        let rightBarBtn = UIBarButtonItem(image: UIImage(named: "sort"), style: .plain, target: self, action: #selector(showSortOptions))
        self.navigationItem.rightBarButtonItem = rightBarBtn
    }
    
    private func configureTableView() {
        self.presenter?.applySort(self.selectedSort)
        self.searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "RestaurantListTableViewCell", bundle: nil), forCellReuseIdentifier: RestaurantListTableViewCell.identifier)
        self.tableView.register(UINib(nibName: "FavoritesListView", bundle: nil), forHeaderFooterViewReuseIdentifier: FavoritesListView.identifier)
        self.createTableHeaderView()
    }
    
    private func createTableHeaderView() {
        let width = UIScreen.main.bounds.size.width
        if let headerView = self.tableView?.dequeueReusableHeaderFooterView(withIdentifier: FavoritesListView.identifier) as? FavoritesListView {
            let favorites = self.presenter?.restaurants?.filter { UserDefaults.standard.bool(forKey: $0.name ?? "") == true } ?? []
            let height = CGFloat(115 * favorites.count)
            headerView.frame = CGRect(x: 0, y: 0, width: width, height: height)
            headerView.configureView(favorites, selectedSort: self.selectedSort)
            headerView.delegate = self
            self.favoritesView = headerView
            self.tableView?.tableHeaderView = headerView
        }
    }
    
    ///The presentation of sorting options could be improved
    @objc private func showSortOptions() {
        let actionSheet = UIAlertController(title: "Select Sorting Option", message: "", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "bestMatch", style: .default, handler: { [weak self] (action) in
            self?.selectedSort = .bestMatch
            self?.presenter?.applySort(self?.selectedSort)
        }))
        actionSheet.addAction(UIAlertAction(title: "newest", style:.default, handler: { [weak self] (action) in
            self?.selectedSort = .newest
            self?.presenter?.applySort(self?.selectedSort)
        }))
        actionSheet.addAction(UIAlertAction(title: "ratingAverage", style:.default, handler: { [weak self] (action) in
            self?.selectedSort = .ratingAverage
            self?.presenter?.applySort(self?.selectedSort)
        }))
        actionSheet.addAction(UIAlertAction(title: "distance", style:.default, handler: { [weak self] (action) in
            self?.selectedSort = .distance
            self?.presenter?.applySort(self?.selectedSort)
        }))
        actionSheet.addAction(UIAlertAction(title: "popularity", style:.default, handler: { [weak self] (action) in
            self?.selectedSort = .popularity
            self?.presenter?.applySort(self?.selectedSort)
        }))
        actionSheet.addAction(UIAlertAction(title: "averageProductPrice", style:.default, handler: { [weak self] (action) in
            self?.selectedSort = .averageProductPrice
            self?.presenter?.applySort(self?.selectedSort)
        }))
        actionSheet.addAction(UIAlertAction(title: "deliveryCosts", style:.default, handler: { [weak self] (action) in
            self?.selectedSort = .deliveryCosts
            self?.presenter?.applySort(self?.selectedSort)
        }))
        actionSheet.addAction(UIAlertAction(title: "minCost", style:.default, handler: { [weak self] (action) in
            self?.selectedSort = .minCost
            self?.presenter?.applySort(self?.selectedSort)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true)
    }
    
}


// MARK: - UISearchBarDelegate

extension RestaurantListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter?.eventSearchBarTextDidChange(searchText)
    }
    
}


// MARK: - RestaurantListPresenterOutput

extension RestaurantListViewController: RestaurantListPresenterOutput {
    
    func reloadViewContent() {
        let favorites = self.presenter?.restaurants?.filter { UserDefaults.standard.bool(forKey: $0.name ?? "") == true } ?? []
        let height = CGFloat(115 * favorites.count)
        self.favoritesView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
        self.tableView.reloadData()
        self.favoritesView?.configureView(favorites, selectedSort: self.selectedSort)
        self.favoritesView?.reloadContentView()
    }
    
}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension RestaurantListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.presenter?.sectionArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 115.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.presenter?.getNumberOfRows(in: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let restaurantCell = tableView.dequeueReusableCell(withIdentifier: RestaurantListTableViewCell.identifier) as? RestaurantListTableViewCell,
           let restaurant = self.presenter?.getRestaurant(at: indexPath) {
            restaurantCell.delegate = self
            restaurantCell.configureCell(with: restaurant, selectedSort: self.selectedSort)
            cell = restaurantCell
        }
        
        return cell
    }
    
}


// MARK: - RestaurantListPresenterOutput

extension RestaurantListViewController: RestaurantListTableViewCellDelegate {
    
    func favoriteStatusChanged() {
        self.reloadViewContent()
    }
    
}
