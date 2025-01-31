//
//  TourListViewController.swift
//  Recipe
//
//  Created by ekbana on 9/12/21.
//
//

import UIKit
import SkeletonView

class ShopListViewController: UIViewController {
    
    // MARK: Properties
    var presenter: ShopListModuleInterface?
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .black
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    private var tourListViewModels = [TourListViewModel]()
    
    private var isMoreDataAvailable: Bool = false
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView?
    
    // MARK: VC's Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        presenter?.viewIsReady(isRefreshing: false)
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
        setupTableView()
    }
    
    // MARK: setupTableView
    private func setupTableView() {
        tableView?.delegate = self
        tableView?.dataSource = self
        
        tableView?.sectionFooterHeight = 0
        
        tableView?.refreshControl = refreshControl
    }
    
    // MARK: reloadTableView
    private func reloadTableView() {
        tableView?.reloadData()
    }
    
    // MARK: objc functions
    // MARK: pullToRefresh
    @objc private func pullToRefresh() {
        presenter?.viewIsReady(isRefreshing: true)
    }
    
}

// MARK: TourListViewInterface
extension ShopListViewController: ShopListViewInterface {
    
    func showSkeletonLoading() {
        view.showAnimatedGradientSkeleton()
    }
    
    func hideSkeletonLoading() {
        view.hideSkeleton()
    }
    
    func showTourList(models: [TourListViewModel], total: Int) {
        refreshControl.endRefreshing()
        tourListViewModels = models
        if tourListViewModels.count < total {
            isMoreDataAvailable = true
        } else {
            isMoreDataAvailable = false
        }
        reloadTableView()
    }
    
}

// MARK: SkeletonTableViewDataSource
extension ShopListViewController: SkeletonTableViewDataSource {
    
    /// sekeletonview
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "TourListTableViewCell"
    }
    
    /// tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tourListViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tourListViewModel = tourListViewModels.element(at: indexPath.item)
        
        let cell: ShopListTableViewCell = tableView.dequeueCell()
        cell.tourListViewModel = tourListViewModel
        return cell
    }
    
}

// MARK: UITableViewDelegate
extension ShopListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let restaurantViewModel = restaurantCategoryViewModel?.subcategories.element(at: indexPath.item) {
//            presenter?.gotoRestaurantContainerScreen(id: restaurantViewModel.id)
//        }
    }
    
    // MARK: for show loading at bottom for pagination
    private func setupFooterView() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44)
        tableView?.tableFooterView = spinner
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: 0)
        if indexPath.row == (lastRowIndex - 1) && isMoreDataAvailable {
            setupFooterView()
            presenter?.getMoreData()
        } else {
            tableView.tableFooterView = nil
        }
        
    }
    
}
