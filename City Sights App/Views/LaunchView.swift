//
//  ContentView.swift
//  City Sights App
//
//  Created by Marco Lau on 25/08/2021.
//

import SwiftUI

struct LaunchView: View {
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        // Detect authorization status
        
        if model.authorisationState == .notDetermined {
            // undetermined: onboarding view
            OnboardingView()
        }
        else if model.authorisationState == .denied {
            // denied: denied view
            DeniedView()
        }
        else {
            // authorised: home view
            HomeView()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
