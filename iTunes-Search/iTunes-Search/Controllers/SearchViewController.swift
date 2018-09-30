//
//  SearchViewController.swift
//  iTunes-Search
//
//  Created by Tharindu Perera on 9/30/18.
//  Copyright © 2018 Tharindu Perera. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var applications : [Application] =  []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        messageLabel.text = "Search Applications."
        messageLabel.isHidden = false
        configSearchController()
        configTableView()
        hideLoading()
    }
    
    private func configSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "App Store"
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = UIColor.white
        
        if let searchBarTextfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            if let backgroundview = searchBarTextfield.subviews.first {
                
                // Background color
                backgroundview.backgroundColor = UIColor.white
                
                // Rounded corner
                backgroundview.layer.cornerRadius = 10
                backgroundview.clipsToBounds = true
            }
        }
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    private func configTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.tableFooterView = UIView()
    }
    
    private func showLoading() {
        applications.removeAll()
        tableView.reloadData()
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func hideLoading() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        
    }
    
    //MARK: - UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        showLoading()
//        messageLabel.text = "No Applications Found."
//        messageLabel.isHidden = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        hideLoading()
        messageLabel.text = "Search Applications."
        messageLabel.isHidden = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        messageLabel.isHidden = true
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return applications.count
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ApplicationCell", for: indexPath) as! ApplicationTableViewCell
        return cell
    }

}
