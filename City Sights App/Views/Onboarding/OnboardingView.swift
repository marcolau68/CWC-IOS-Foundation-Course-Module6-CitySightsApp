//
//  OnboardingView.swift
//  City Sights App
//
//  Created by Marco Lau on 27/08/2021.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var model: ContentModel
    @State private var page = 1
    private let blue = Color(red: 0.0, green: 130.0/255.0, blue: 167.0/255.0)
    private let turqouise = Color(red: 55.0/255.0, green: 197.0/255.0, blue: 192.0/255.0)
    
    var body: some View {
        VStack {
            // Tab Vew
            TabView(selection: $page, content:  {
                
                VStack {
                    Image("city2")
                        .resizable()
                        .scaledToFit()
                    
                    Text("Welcome to City Sights!")
                        .bold()
                        .font(.title)
                    
                    Text("City Sights helps you find the best of the city!")
                }
                .padding()
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .tag(1)
                
                VStack {
                    Image("city1")
                        .resizable()
                        .scaledToFit()
                    
                    Text("Ready to discover your city?")
                        .bold()
                        .font(.title)
                    
                    Text("We'll show you the best restaurants, venues, and more, based on your location! ")

                }
                .padding()
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .tag(2)
                
            })
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            
            // Button
            Button(action: {
                if page == 1 {
                    page = 2
                }
                else {
                    // Request for geolocation permission
                    model.requestLocationPermission()
                }
            }, label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 48)
                        .cornerRadius(10)
                    
                    Text(page == 1 ? "Next":"Get My Location")
                    
                }
            })
            .accentColor(page == 1 ? blue:turqouise)
            .padding(40)
            .padding(.bottom, 40)
            
        }
        .background(page == 1 ? blue:turqouise)
        .ignoresSafeArea()
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
