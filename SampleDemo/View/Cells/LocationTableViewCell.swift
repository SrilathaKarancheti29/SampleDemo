//
//  LocationTableViewCell.swift
//  Sample demo
//
//  Created by Srilatha Karancheti on 2022-04-10.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    static let reuseID = "LocationTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with locationViewModel: LocationViewModel) {
        titleLabel.text = locationViewModel.title
        titleLabel.textColor = locationViewModel.titleColor
    }
    
}
