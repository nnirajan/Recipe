//
//  RecipeListViewController.swift
//  Recipe
//
//  Created by ekbana on 9/11/21.
//
//

import UIKit

class RecipeListViewController: UIViewController {
    
    // MARK: Properties
    
    var presenter: RecipeListModuleInterface?
    
    // MARK: IBOutlets
    
    // MARK: VC's Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        
        view.backgroundColor = .red
    }
    
    // MARK: IBActions
    
    // MARK: Other Functions
    
    private func setup() {
        // all setup should be done here
    }
}

// MARK: RecipeListViewInterface
extension RecipeListViewController: RecipeListViewInterface {
    
}
