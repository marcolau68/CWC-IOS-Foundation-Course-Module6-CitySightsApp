//
//  DeniedView.swift
//  City Sights App
//
//  Created by Marco Lau on 27/08/2021.
//

import SwiftUI

struct DeniedView: View {
    private let backgroundColor = Color(red: 34.0/255.0, green: 141.0/255.0, blue: 138.0/255.0)
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Text("Whoops!")
                .bold()
                .font(.title)
                .foregroundColor(.white)
            
            Text("We need to access your location to provide you with the best sights in the city. You can change your decision at any time in Settings.")
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
            
            Spacer()
            
            Button(action: {
                // Open Settings
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        
                    }
                }
                
            }, label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 48)
                        .cornerRadius(10)
                    
                    Text("Go to Settings")
                        .bold()
                        .foregroundColor(backgroundColor)
                        .padding()
                }
            })
            .padding(.horizontal, 30)
            
            Spacer()
        }
        .background(backgroundColor)
        .ignoresSafeArea(.all, edges: .all)
        
        
    }
}

struct DeniedView_Previews: PreviewProvider {
    static var previews: some View {
        DeniedView()
    }
}
