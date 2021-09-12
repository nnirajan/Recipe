//
//  TourListViewController.swift
//  Recipe
//
//  Created by ekbana on 9/12/21.
//
//

import UIKit
import SkeletonView

class TourListViewController: UIViewController {
    
    // MARK: Properties
    var presenter: TourListModuleInterface?
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView?
    
    // MARK: VC's Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "tour list"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = ""
    }
    
    // MARK: IBActions
    
    // MARK: Other Functions
    private func setup() {
        // all setup should be done here
    }
    
}

// MARK: TourListViewInterface
extension TourListViewController: TourListViewInterface {
    
    func showLoading() {
//        showProgressHud()
    }
    
    func hideLoading() {
//        hideProgressHud()
    }
    
    func showSkeletonLoading() {
        view.showAnimatedGradientSkeleton()
    }
    
    func hideSkeletonLoading() {
        view.hideSkeleton()
    }
    
}
