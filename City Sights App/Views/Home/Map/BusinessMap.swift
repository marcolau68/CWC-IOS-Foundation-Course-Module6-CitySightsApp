//
//  BusinessMap.swift
//  City Sights App
//
//  Created by Marco Lau on 26/08/2021.
//

import SwiftUI
import MapKit

struct BusinessMap: UIViewRepresentable {
    @EnvironmentObject var model: ContentModel
    @Binding var selectedBusiness: Business?
    
    var locations: [MKPointAnnotation] {
        var annotations = [MKPointAnnotation]()
        
        for business in model.restaurants + model.sights {
            
            if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
                let a = MKPointAnnotation()
                a.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                a.title = business.name ?? ""
                
                annotations.append(a)
            }
        }
        
        return annotations
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        // map tracks user and user and direction
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Remove old annotations
        uiView.removeAnnotations(uiView.annotations)
        
        // Add new annotations
        uiView.showAnnotations(self.locations, animated: true)
        
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        
        uiView.removeAnnotations(uiView.annotations)
    }
    
    // MARK: Coordinator class (for MapVieww)
    func makeCoordinator() -> Coordinator {
        return Coordinator(map: self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        
        var map: BusinessMap
        
        init(map: BusinessMap) {
            self.map = map
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            // exclude user blue dot
            if annotation is MKUserLocation {
                return nil
            }
            
            // check if there is a reusable view first (save memory to reuse)
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.reusableAnnotationId)
            
            if annotationView == nil {
                // Create an annotation view
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: Constants.reusableAnnotationId)
                
                annotationView!.canShowCallout = true
                annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
            else {
                // Use a resuable one
                annotationView!.annotation = annotation
            }
            

            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            
            // User tapped on annotationView
            
            // Get business object this annotation represents
            // set the selectedBusiness to the right business object
            for business in map.model.restaurants + map.model.sights {
                if view.annotation?.title  == business.name {
                    map.selectedBusiness = business
                    return
                }
            }
        }
    }

}

