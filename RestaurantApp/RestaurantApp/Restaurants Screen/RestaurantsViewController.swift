//
//  RestaurantsViewController.swift
//  RestaurantApp
//
//  Created by Tristan Newman on 1/31/21.
//

import UIKit

class RestaurantsViewController: BaseViewController, RestaurantsViewModelDelegate, UITableViewDataSource {
    // MARK: - Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(RestaurantTableViewCell.self, forCellReuseIdentifier: RestaurantTableViewCell.className)
        tableView.separatorStyle = .none
        return tableView
    }()

    private lazy var viewModel: RestaurantsViewModel = {
        let viewModel = RestaurantsViewModel()
        viewModel.delegate = self
        return viewModel
    }()

    // MARK: - Life cycle
    override func loadView() {
        super.loadView()
        setupViews()
        setupNavigationBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadData()
    }

    // MARK: - Methods
    private func setupViews() {
        view.backgroundColor = .blue
        view.addSubview(tableView)
        layoutConstraint()
    }

    private func layoutConstraint() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setupNavigationBar() {
        title = "Restaurants"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.tintColor = .black
    }

    // MARK: - RestaurantsViewModelDelegate
    func restaurantsViewModel(viewModel: RestaurantsViewModel, didLoadData data: [Restaurant]) {
        tableView.reloadData()
    }

    func restaurantsViewModel(viewModel: RestaurantsViewModel, failedLoadData error: AppError) {
        AppAlert.shared.showBasic(title: "Error", message: error.message,
                                 viewController: self)
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRestaurants()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.className) as? RestaurantTableViewCell else {
            return UITableViewCell()
        }
        
        cell.restaurant = viewModel.getRestaurant(byIndex: indexPath.row)
        return cell
    }
}
