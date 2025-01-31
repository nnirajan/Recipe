//
//  ShopListTableViewCell.swift
//  Recipe
//
//  Created by Nirajan on 9/12/21.
//

import UIKit

class ShopListTableViewCell: UITableViewCell {

    // MARK: properties
    var shopListViewModel: ShopListViewModel? {
        didSet {
            setupData()
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
        shopImageView.set(cornerRadius: 8)
        shopImageView.set(borderWidth: 1, of: CustomColors.borderColor)
    }
    
    // MARK: setupLabels
    private func setupLabels() {
        /// titleLabel
        titleLabel.textColor = CustomColors.textColor
//        titleLabel.font = CustomFont.medium.font(ofHeading: .heading3)
    }
    
    // MARK: setupData
    private func setupData() {
        titleLabel.text = shopListViewModel?.title
        shopImageView.setImage(urlString: shopListViewModel?.imageURL)
    }
    
}
