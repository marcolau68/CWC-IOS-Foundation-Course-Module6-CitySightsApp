//
//  BusinessDetailView.swift
//  City Sights App
//
//  Created by Marco Lau on 26/08/2021.
//

import SwiftUI

struct BusinessDetailView: View {
    var business: Business
    @State private var showDirections = false
    
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
            
            HStack {
                BusinessTitle(business: business)
                    .padding(.horizontal)
                
                Spacer()
                
                Yelp(link: business.url!)
            }
            
            DashedDivider()
                .padding(.horizontal)
            
            // Phone
            HStack {
                Text("Phone: ")
                    .bold()
                Text(business.displayPhone ?? "")
                
                Spacer()
                
                Link("Call", destination: URL(string: "tel:\(business.phone ??  "")")!)
            }
            .padding()
            
            DashedDivider()
                .padding(.horizontal)
            
            // Reviews
            HStack {
                Text("Reviews: ")
                    .bold()
                Text(String(business.reviewCount ?? 0))
                
                Spacer()
                
                Link("Read", destination: URL(string: business.url ?? "")!)
            }
            .padding()

            DashedDivider()
                .padding(.horizontal)

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

            DashedDivider()
                .padding(.horizontal)

            // Button
            Button(action: {
                showDirections = true
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
            .sheet(isPresented: $showDirections, content: {
                DirectionsView(business: business)
            })
        }
        
    }
}







