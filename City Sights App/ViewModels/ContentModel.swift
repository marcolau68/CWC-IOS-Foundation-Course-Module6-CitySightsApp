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
    
    @Published var restaurants = [Business]()
    @Published var sights = [Business]()
    
    @Published var authorisationState = CLAuthorizationStatus.notDetermined
    
    @Published var placeMark: CLPlacemark?
    
    
    // NSObject needed for ContentModel to conform to CLLocationManagerDelegate
    // NSObject has its own init method, needs to override
    override init() {
        // Init for NSObject
        super.init()
        
        // Set content model as the delegate  of the location manager
        locationManager.delegate = self
    }
    
    func requestLocationPermission() {
        // Request permission from user
        locationManager.requestWhenInUseAuthorization()
    }
    
    // MARK: Location Manager Delegate Methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        // update authorisationState
        authorisationState = locationManager.authorizationStatus
        
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
            getBusinesses(category: Constants.restaurantKey, location: userLocation!)
            getBusinesses(category: Constants.sightsKey, location: userLocation!)
            
            // Get the place mark of the user
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(userLocation!) { (placeMarks, error) in
                if error == nil && placeMarks != nil {
                    self.placeMark = placeMarks?.first
                }
            }
            
            // Stop updating after we get it once
            locationManager.stopUpdatingLocation()
        }
        
    }
    
    // MARK: Yelp API methods
    func getBusinesses(category: String, location: CLLocation) {
        
        // Create url
//        let urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longtitude=\(location.coordinate.longitude)&categories=\(category)&limit=6"
//        let url = URL(string: urlString)
        
        var urlComponents = URLComponents(string: Constants.yelpSearchURL)
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "6")
        ]
        
        let url = urlComponents?.url
        
        if let url = url {
            // Create URL request
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = Constants.yelpSearchHTTPMethod
            request.addValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
            
            // Create URL session
            let session = URLSession.shared
            
            // Create data task
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                // Check there is no error
                if error == nil {
                    // parse JSON
                    let decoder = JSONDecoder()
                    
                    do {
                        let result = try decoder.decode(BusinessSearch.self, from: data!)
                        
                        var businesses = result.businesses
                        
                        // sort businesses by distance, if b1 is closer than b2, b1 goes before b2
                        businesses.sort { (b1, b2) -> Bool in
                            return b1.distance ?? 0 < b2.distance ?? 0
                        }
                        
                        for b in businesses {
                            b.getImageData()
                        }
                        
                        // Assign business by category
                        DispatchQueue.main.async {
                            switch category {
                            case "restaurants":
                                self.restaurants = businesses
                            case "arts":
                                self.sights = businesses
                            default:
                                break
                            }
                        }
                        
                    }
                    catch {
                        
                    }
                }
            }
            
            // Start data task
            dataTask.resume()
            
        }
    
    }

    
}







