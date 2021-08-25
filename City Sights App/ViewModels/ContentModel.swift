//
//  ContentModel.swift
//  City Sights App
//
//  Created by Marco Lau on 25/08/2021.
//

import Foundation
import CoreLocation

class ContentModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    var locationManager = CLLocationManager()
    
    
    // NSObject needed for ContentModel to conform to CLLocationManagerDelegate
    // NSObject has its own init method, needs to override
    override init() {
        // Init for NSObject
        super.init()
        
        // Set content model as the delegate  of the location manager
        locationManager.delegate = self
        
        // Request permission from user
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    // MARK: Location Manager Delegate Methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse  {
            // We have permission, update location
            locationManager.startUpdatingLocation()
        }
        else if locationManager.authorizationStatus == .denied {
            // we don't have permission
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Give us the location
        let userLocation = locations.first
        
        if userLocation != nil {
            // If we have the location, send cords to Yelp API
            getBusinesses(category: "restaurants", location: userLocation!)
//            getBusinesses(category: "arts", location: userLocation!)
            
            // Stop updating after we get it once
            locationManager.stopUpdatingLocation()
        }
        
    }
    
    // MARK: Yelp API methods
    func getBusinesses(category: String, location: CLLocation) {
        
        // Create url
//        let urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longtitude=\(location.coordinate.longitude)&categories=\(category)&limit=6"
//        let url = URL(string: urlString)
        
        var urlComponents = URLComponents(string: "https://api.yelp.com/v3/businesses/search")
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limt", value: "6")
        ]
        
        let url = urlComponents?.url
        
        if let url = url {
            // Create URL request
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue("Bearer 9lZ0gZqYI6BsDYSDjXTAbbDLpG6pDiMw9y9KlwRLx9NQtKIm3v-BH9N9T7j3id-rU0pSdZ4Ea1hTjzyOY8mK3T8tc4Jt5mWFQaNs_fPx7bjNcswRlL5Tw9AiYK4lYXYx", forHTTPHeaderField: "Authorization")
            
            // Create URL session
            let session = URLSession.shared
            
            // Create data task
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                // Check there is no error
                if error == nil {
                    print(response)
                }
            }
            
            // Start data task
            dataTask.resume()
            
        }
    
    }

    
}







