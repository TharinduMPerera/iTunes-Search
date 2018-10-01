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
    
    private var applications : [Application] =  []
    private let apiCommunicator = APICommunicator()
    private let searchController = UISearchController(searchResultsController: nil)
    private var isCanceledTapped = false
    private var selectedApplication : Application?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        messageLabel.text = "Search Applications."
        messageLabel.isHidden = false
        configSearchController()
        configTableView()
        hideLoading()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetails" {
            if let detailsViewController = segue.destination as? DetailsViewController {
                detailsViewController.application = self.selectedApplication
            }
        }
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
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    private func hideLoading() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
    }
    
    private func clearTable() {
        applications.removeAll()
        tableView.reloadData()
    }
    
    //MARK: - UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isCanceledTapped = false
        messageLabel.isHidden = true
        clearTable()
        showLoading()
        apiCommunicator.fetchApplications(searchTerm: searchBar.text ?? "") { (success, data, error) in
            DispatchQueue.main.async {
                self.hideLoading()
                if(success){
                    if let data = data {
                        if data.count > 0 {
                            self.applications = data
                            self.tableView.reloadData()
                        } else {
                            self.messageLabel.text = "No Applications Found."
                            self.messageLabel.isHidden = false
                        }
                    }
                } else {
                    if(!self.isCanceledTapped){
                        self.messageLabel.text = error
                        self.messageLabel.isHidden = false
                    }
                }
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isCanceledTapped = true
        apiCommunicator.cancel()
        clearTable()
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
        cell.setDetails(application: applications[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedApplication = applications[indexPath.row]
        performSegue(withIdentifier: "ShowDetails", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
