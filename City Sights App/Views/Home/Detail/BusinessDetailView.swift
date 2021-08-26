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
        let uiImage = UIImage(data: business.imageData ?? Data())
        
        VStack {
            GeometryReader { geo in
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()
            }
            
            ZStack(alignment: .leading)  {
                
                Rectangle()
                    .frame(height: 36)
                    .foregroundColor((business.isClosed ?? true) ? Color(.sRGB, red: 0.6, green: 0.6, blue: 0.6, opacity: 0.6):Color(.sRGB, red: 0, green: 0.3, blue: 0.5, opacity: 0.8))
                
                Text((business.isClosed ?? true) ? "Closed":"Open")
                    .foregroundColor(.white)
                    .padding()
                
            }
            
            VStack(alignment: .leading) {
                // Business name
                Text(business.name ?? "")
                    .bold()
                    .font(.title)
                
                // Address and Yelp image
                if business.location?.displayAddress != nil {
                    ForEach(business.location!.displayAddress!, id: \.self) { line in
                        Text(line)
                            .font(.caption)
                    }
                }
                
                // Rating
                Image("regular_\(business.rating ?? 0.0)")
                
                Divider()
                
                // Phone
                HStack {
                    HStack(spacing: 5) {
                        Text("Phone: ")
                            .bold()
                        Text(business.phone ?? "")
                    }
                    
                    Spacer()
                    
                    Text("Call")
                }
                .padding(.vertical)
                
                Divider()
                
                // Reviews
                ContactRow(via: "Reviews", address: String(business.reviewCount ?? 0), keyword: "Read", url: business.url ?? "")
                
                // Website
                ContactRow(via: "Website", address: business.url ?? "", keyword: "Visit", url: business.url ?? "")
                    
            }
            .padding(.horizontal)
        }
        .ignoresSafeArea(edges: .top)
        
        
    }
}







