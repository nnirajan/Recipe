//
//  ShopListViewController.swift
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
    
    private var shopListViewModels = [ShopListViewModel]()
    
    var users = [User]()
    
    private var isMoreDataAvailable: Bool = false
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var dummyScrollView: UIScrollView!
    
    // MARK: VC's Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        presenter?.viewIsReady(isRefreshing: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "shop list"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = ""
    }
    
    // MARK: IBActions
    
    // MARK: Other Functions
    private func setup() {
        // all setup should be done here
//        showDummyScrollViewOnly()
        setupTableView()
    }
    
    // MARK: showTableViewViewOnly
    private func showTableViewViewOnly() {
        dummyScrollView?.isHidden = true
        tableView?.isHidden = false
    }
    
    // MARK: showDummyScrollViewOnly
    private func showDummyScrollViewOnly() {
        dummyScrollView?.isHidden = false
        tableView?.isHidden = true
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

// MARK: ShopListViewController
extension ShopListViewController: ShopListViewInterface {
    
    func showSkeletonLoading() {
        view.showAnimatedGradientSkeleton()
    }
    
    func hideSkeletonLoading() {
//        showTableViewViewOnly()
        view.hideSkeleton()
    }
    
    func showShopList(models: [ShopListViewModel], total: Int) {
        refreshControl.endRefreshing()
        shopListViewModels = models
        if shopListViewModels.count < total {
            isMoreDataAvailable = true
        } else {
            isMoreDataAvailable = false
        }
        reloadTableView()
    }
    
    func user(model: [User]) {
        users = model
        reloadTableView()
    }
    
}

// MARK: SkeletonTableViewDataSource
extension ShopListViewController: UITableViewDataSource {
    
    /// sekeletonview
//    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
//        return "ShopListTableViewCell"
//    }
    
    /// tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
//        return shopListViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let shopListViewModel = shopListViewModels.element(at: indexPath.item)
//
//        let cell: ShopListTableViewCell = tableView.dequeueCell()
//        cell.shopListViewModel = shopListViewModel
//        return cell
        
        let user = users.element(at: indexPath.item)
        
        let cell: ShopListTableViewCell = tableView.dequeueCell()
        cell.user = user
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
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.startAnimating()
        spinner.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
        tableView?.tableFooterView = spinner
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: 0)
        if indexPath.item == (lastRowIndex - 1) && isMoreDataAvailable {
            setupFooterView()
            presenter?.getMoreData()
        } else {
            tableView.tableFooterView = nil
        }
        
    }
    
}
