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
    @State var selectedBusiness: Business?
    
    var body: some View {
        if model.restaurants.count != 0 || model.sights.count != 0 {
            
            NavigationView {
                if isMapShowing {
                    // Show map
                    BusinessMap(selectedBusiness: $selectedBusiness)
                    .ignoresSafeArea()
                        .sheet(item: $selectedBusiness) { business in
                            BusinessDetailView(business: business)
                        }
                }
                else {
                    // Show list
                    VStack {
                        HStack {
                            Image(systemName: "location")
                            Text("Hong Kong")
                            Spacer()
                            Button("Switch to Map View", action: {
                                isMapShowing = true
                            })
                        }
                        .padding(.horizontal, 10)
                        
                        Divider()
                        
                        BusinessList()
                    }
                }
            }
            .navigationBarHidden(true)
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
