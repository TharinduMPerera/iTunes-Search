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
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        
        configSearchController()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func configSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Application"
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
    
    //MARK: - UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ApplicationCell", for: indexPath) as! ApplicationTableViewCell
        return cell
    }

}
