//
//  ApplicationTableViewCell.swift
//  iTunes-Search
//
//  Created by Tharindu Perera on 9/30/18.
//  Copyright © 2018 Tharindu Perera. All rights reserved.
//

import UIKit

class ApplicationTableViewCell: UITableViewCell {

    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var seller: UILabel!
    @IBOutlet weak var thubnailImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setDetails(application: Application) {
        appName.text = application.trackName.isEmpty ? "Name: N/A" : application.trackName
        seller.text = application.sellerName.isEmpty ? "Seller: N/A" : application.sellerName
        thubnailImage.loadFromUrl(url: application.artworkUrl100)
    }

}
