//
//  ProductDetailViewController.swift
//  Recipe
//
//  Created by ekbana on 9/12/21.
//
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    // MARK: Properties
    var presenter: ProductDetailModuleInterface?
    
    // MARK: IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: VC's Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        presenter?.viewIsReady()
    }
    
    // MARK: IBActions
    
    // MARK: Other Functions
    private func setup() {
        // all setup should be done here
        self.title = "Product Detail"
        setupImageView()
        setupLabels()
    }
    
    // MARK: setupimageview
    private func setupImageView() {
        imageView.set(cornerRadius: 8)
        imageView.set(borderWidth: 1, of: CustomColors.borderColor)
    }
    
    // MARK: setupLabels
    private func setupLabels() {
        /// titleLabel
        titleLabel.textColor = CustomColors.textColor
        
        descriptionLabel.textColor = CustomColors.textColor
    }
    
}

// MARK: ProductDetailViewInterface
extension ProductDetailViewController: ProductDetailViewInterface {
    
    func showSkeletonLoading() {
        view.showAnimatedGradientSkeleton()
    }
    
    func hideSkeletonLoading() {
        view.hideSkeleton()
    }
    
    func showProductDetail(model: ProductDetailViewModel?) {
        imageView.setImage(urlString: model?.imageURL)
        titleLabel.text = model?.title
        descriptionLabel.attributedText = model?.description.htmlToAttributedString
    }
    
}
