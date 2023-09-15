//
//  ShopListEmptyView.swift
//  Recipe
//
//  Created by Nirajan on 9/12/21.
//

import UIKit

class ShopListEmptyView: UIView {
    
    // MARK:- Properties
    private let imageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "empty")
        imageview.contentMode = .scaleAspectFit
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.textColor = CustomColors.textColor
        label.font = label.font.withSize(24)
        label.text = "No Data Found"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [imageView, emptyLabel])
        sv.axis = .vertical
        sv.alignment = .center
        sv.distribution = .fill
        sv.spacing = 38
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    //MARK:- Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("I am being deinalized")
    }

    // MARK: setupViews
    private func setupViews(){
        setupImageView()
        setupStackView()
    }
    
    private func setupImageView() {
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    private func setupStackView() {
        self.addSubview(stackView)
        
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 170).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40).isActive = true
    }
    
}

