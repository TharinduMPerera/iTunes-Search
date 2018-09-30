//
//  SearchViewController.swift
//  iTunes-Search
//
//  Created by Tharindu Perera on 9/30/18.
//  Copyright © 2018 Tharindu Perera. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        
        configDearchBar()
    }
    
    private func configDearchBar() {
        self.searchBar.layer.borderWidth = 1
        self.searchBar.layer.borderColor = UIColor(named: "PrimaryColor")?.cgColor
        self.searchBar.delegate = self
    }
    
    //MARK: - UISearchBarDelegate DataSource
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }

}
