//
//  RestaurantListTableViewCell.swift
//  JustEatTakeAway
//
//  Created by sania zafar on 19/02/2021.
//

import UIKit

protocol RestaurantListTableViewCellDelegate: NSObject {
    
    func favoriteStatusChanged()
    
}

class RestaurantListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var openingStateLabel: UILabel!
    @IBOutlet weak var sortTypeLabel: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    static let identifier = "RestaurantListTableViewCell"
    weak var delegate: RestaurantListTableViewCellDelegate?

    
    // MARK: - Public
    
    func configureCell(with restuarant: Restaurant, selectedSort: SortValue) {
        self.nameLabel.text = restuarant.name ?? ""
        self.openingStateLabel.text = restuarant.status ?? ""
        self.favoriteBtn.isSelected = UserDefaults.standard.bool(forKey: self.nameLabel.text ?? "")
        if let sortValue = restuarant.sortingValues?[selectedSort.rawValue] {
            self.sortTypeLabel.text = "\(selectedSort.rawValue): \(sortValue)"
        }
    }
    
    
    // MARK: - IBAction
    
    @IBAction func tappedFavorite(_ sender: UIButton) {
        self.favoriteBtn.isSelected.toggle()
        UserDefaults.standard.set(self.favoriteBtn.isSelected, forKey: self.nameLabel.text ?? "")
        UserDefaults.standard.synchronize()
        self.delegate?.favoriteStatusChanged()
    }
    
}
