//
//  APICommunicator.swift
//  iTunes-Search
//
//  Created by Tharindu Perera on 9/30/18.
//  Copyright © 2018 Tharindu Perera. All rights reserved.
//

import Foundation

class APICommunicator {
    
    typealias JSONDictionary = [String: Any]
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var errorMessage = ""
    
    func fetchApplications(searchTerm: String, completion: @escaping (Bool, [Application]?, String) -> ()){
        dataTask?.cancel()
        
        if var urlComponents = URLComponents(string: "https://itunes.apple.com/search") {
            urlComponents.query = "limit=200&entity=software&term=\(searchTerm)"
            
            guard let url = urlComponents.url else { return }
            
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }
                
                if response == nil {
                    self.errorMessage = "No Internet Connection."
                    completion(false, nil, self.errorMessage)
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    completion(true, self.extractApplicationData(data), self.errorMessage)
                } else {
                    self.errorMessage = "Something Went Wrong."
                    completion(false, nil, self.errorMessage)
                }
            }
            dataTask?.resume()
        }
    }
    
    func cancel() {
        dataTask?.cancel()
    }
    
    fileprivate func extractApplicationData(_ data: Data) -> [Application]{
        var response: JSONDictionary?
        var applications : [Application] = []
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            print("JSONSerialization error: \(parseError.localizedDescription)\n")
            return applications
        }
        
        guard let results = response!["results"] as? [Any] else {
            print("Dictionary does not contain results key")
            return applications
        }
        
        for appDictionary in results {
            if let appDictionary = appDictionary as? JSONDictionary,
                let trackName = appDictionary["trackName"] as? String,
                let sellerName = appDictionary["sellerName"] as? String,
                let version = appDictionary["version"] as? String,
                let wrapperType = appDictionary["wrapperType"] as? String,
                let primaryGenreName = appDictionary["primaryGenreName"] as? String,
                let formattedPrice = appDictionary["formattedPrice"] as? String,
                let artworkUrl100 = appDictionary["artworkUrl100"] as? String,
                let contentAdvisoryRating = appDictionary["contentAdvisoryRating"] as? String {
                var rating: Float?
                if let averageUserRating = appDictionary["averageUserRating"] as? Float {
                    rating = averageUserRating
                }
                applications.append(Application(trackName: trackName, sellerName: sellerName, version: version, wrapperType: wrapperType, primaryGenreName: primaryGenreName, formattedPrice: formattedPrice, artworkUrl100: artworkUrl100, averageUserRating: rating, contentAdvisoryRating: contentAdvisoryRating))
            } else {
                print("Problem parsing appDictionary")
            }
        }
        
        return applications
    }
}
