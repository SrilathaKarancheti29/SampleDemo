//
//  PropertyListTableViewCell.swift
//  Sample demo
//
//  Created by Srilatha Karancheti on 2022-04-08.
//

import UIKit

class PropertyListTableViewCell: UITableViewCell {
     
    static let reuseID = "PropertyListTableViewCell"

    @IBOutlet weak var propertyImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(with viewModel: PropertyListViewModel) {
        propertyImageView.downloadImage(fromURL: viewModel.imageURL)
        priceLabel.text = viewModel.price
        sizeLabel.text = viewModel.size
        addressLabel.text = viewModel.address
    }
    
}

extension UIImageView {
    
    func downloadImage(fromURL urlString: String) {
        Task {
            image = await FakeNetworkSession.shared.downloadImage(fromURLString: urlString)!
        }
    }
}
