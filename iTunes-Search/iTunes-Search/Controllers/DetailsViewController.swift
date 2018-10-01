//
//  DetailsViewController.swift
//  iTunes-Search
//
//  Created by Tharindu Perera on 9/30/18.
//  Copyright © 2018 Tharindu Perera. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sellerLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var ageRatingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var application : Application?

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDetails()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func  setDetails() {
        if let app = application {
            thumbnailImage.loadFromUrl(url: app.artworkUrl100)
            nameLabel.text = app.trackName
            sellerLabel.text = app.sellerName
            versionLabel.text = app.version
            ratingLabel.text = app.averageUserRating == nil ? "N/A" : "\(app.averageUserRating!)"
            categoryLabel.text = app.primaryGenreName
            ageRatingLabel.text = app.contentAdvisoryRating
            priceLabel.text = app.formattedPrice
        }
    }

}
