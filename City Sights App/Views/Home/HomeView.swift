//
//  HomeView.swift
//  City Sights App
//
//  Created by Marco Lau on 25/08/2021.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model: ContentModel
    @State var isMapShowing = false
    
    var body: some View {
        if model.restaurants.count != 0 || model.sights.count != 0 {
            
            if isMapShowing {
                // Show map
            }
            else {
                // Show list
                VStack {
                    HStack {
                        Image(systemName: "location")
                        Text("Hong Kong")
                        Spacer()
                        Text("Switch to Map View")
                    }
                    .padding(.horizontal, 10)
                    
                    Divider()
                    
                    BusinessList()
                }
            }
        }
        else {
            ProgressView()
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
