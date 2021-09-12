//
//  ShopListTableViewCell.swift
//  Recipe
//
//  Created by ekbana on 9/12/21.
//

import UIKit

class ShopListTableViewCell: UITableViewCell {

    // MARK: properties
    var shopListViewModel: ShopListViewModel? {
        didSet {
            setupData()
        }
    }
    
    var user: User? {
        didSet{
            titleLabel.text = user?.first_name
            shopImageView.setImage(urlString: user?.avatar)
        }
    }
    
    // MARK: IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var shopImageView: UIImageView!

    // MARK: cell lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }

    // MARK: IBActions
    
    // MARK: private functions
    private func setup() {
        setupImageView()
        setupLabels()
    }
    
    // MARK: setupimageview
    private func setupImageView() {
//        productImageView.set(cornerRadius: 8)
    }
    
    // MARK: setupLabels
    private func setupLabels() {
        /// titleLabel
//        titleLabel.textColor = .offerTextColor
//        titleLabel.font = CustomFont.medium.font(ofHeading: .heading3)
    }
    
    // MARK: setupData
    private func setupData() {
        titleLabel.text = shopListViewModel?.title
        shopImageView.setImage(urlString: shopListViewModel?.imageURL)
    }
    
}
