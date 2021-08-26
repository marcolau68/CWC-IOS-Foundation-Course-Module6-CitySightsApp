//
//  BusinessDetailView.swift
//  City Sights App
//
//  Created by Marco Lau on 26/08/2021.
//

import SwiftUI

struct BusinessDetailView: View {
    var business: Business
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 0) {
                GeometryReader { geo in
                    let uiImage = UIImage(data: business.imageData ?? Data())

                    Image(uiImage: uiImage ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipped()
                }
                .ignoresSafeArea(.all, edges: .top)
                
                ZStack(alignment: .leading)  {
                    
                    Rectangle()
                        .frame(height: 36)
                        .foregroundColor((business.isClosed ?? true) ? Color(.sRGB, red: 0.6, green: 0.6, blue: 0.6, opacity: 0.6):Color(.sRGB, red: 0, green: 0.3, blue: 0.5, opacity: 0.8))
                    
                    Text((business.isClosed ?? true) ? "Closed":"Open")
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    
                }
            }
            
            VStack (alignment: .leading, spacing: 15) {
                // Business name
                Text(business.name ?? "")
                    .bold()
                    .font(.title)
                
                // Address and Yelp image
                if business.location != nil {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("\(business.location!.address1!), \(business.location!.city!)")
                            .font(.caption)
                        Text("\(business.location!.state!), \(business.location!.country!)")
                            .font(.caption)
                    }
                }
                
                // Rating
                Image("regular_\(business.rating ?? 0.0)")
                
            }
            .padding(.horizontal)
            
            Divider()
            
            // Phone
            HStack {
                Text("Phone: ")
                    .bold()
                Text(business.displayPhone ?? "")
                
                Spacer()
                
                Link("Call", destination: URL(string: "tel:\(business.phone ??  "")")!)
            }
            .padding()
            
            Divider()
            
            // Reviews
            HStack {
                Text("Reviews: ")
                    .bold()
                Text(String(business.reviewCount ?? 0))
                
                Spacer()
                
                Link("Read", destination: URL(string: business.url ?? "")!)
            }
            .padding()
            
            Divider()
            
            // Website
            HStack {
                Text("Website: ")
                    .bold()
                Text(String(business.url ?? ""))
                    .lineLimit(1)
                
                Spacer()
                
                Link("Visit", destination: URL(string: business.url ?? "")!)
            }
            .padding()
            
            Divider()
            
            // Button
            Button(action: {
                
            }, label: {
                ZStack {
                    Rectangle()
                        .frame(height: 48)
                        .foregroundColor(.blue)
                        .cornerRadius(15)
                    
                    Text("Get Direction")
                        .bold()
                        .foregroundColor(.white)
                }
            })
            .padding()
        }
        
    }
}







