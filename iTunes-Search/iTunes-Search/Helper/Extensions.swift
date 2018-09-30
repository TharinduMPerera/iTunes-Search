//
//  Extensions.swift
//  iTunes-Search
//
//  Created by Tharindu Perera on 9/30/18.
//  Copyright © 2018 Tharindu Perera. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func loadFromUrl(url: String) {
        if let imageUrl:URL = URL(string: url) {
            DispatchQueue.global(qos: .userInitiated).async {
                let imageData:NSData = NSData(contentsOf: imageUrl)!
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData as Data)
                    self.image = image
                }
            }
        }
    }
    
}
