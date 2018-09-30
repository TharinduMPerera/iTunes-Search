//
//  APICommunicator.swift
//  iTunes-Search
//
//  Created by Tharindu Perera on 9/30/18.
//  Copyright © 2018 Tharindu Perera. All rights reserved.
//

import Foundation

class APICommunicator {
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var apps: [Application] = []
    var errorMessage = ""
    
    func fetchApplications(searchTerm: String, completion: @escaping (Bool, [Application]?, String) -> ()){
        dataTask?.cancel()
        
        if var urlComponents = URLComponents(string: "https://itunes.apple.com/search") {
            urlComponents.query = "limit=200&entity=software&term=\(searchTerm)"
            
            guard let url = urlComponents.url else { return }
            
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }
                
                if response == nil {
                    self.errorMessage = "No internet connection."
                    completion(false, self.apps, self.errorMessage)
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                   
                } else {
                    self.errorMessage = "Something went wrong."
                    completion(false, self.apps, self.errorMessage)
                }
            }
            dataTask?.resume()
        }
    }
}
