//
//  BusinessRow.swift
//  City Sights App
//
//  Created by Marco Lau on 25/08/2021.
//

import SwiftUI

struct BusinessRow: View {
    @ObservedObject var business: Business
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                // Picture
                let uiImage = UIImage(data: business.imageData ?? Data())
               
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .frame(width: 58, height: 58)
                    .cornerRadius(5)
                    .scaledToFit()
                
                VStack(alignment: .leading) {
                    // Name
                    Text(business.name ??  "")
                        .bold()
                    //  Distance
                    Text(String(format: "%.1f km away", (business.distance ?? 0.0)/1000))
                        .font(.caption)
                }
                
                Spacer()
                
                VStack {
                    // Rating
                    Image("regular_\(business.rating ?? 0.0)")
                    // Number of ratings
                    Text("\(business.reviewCount ?? 0) Reviews")
                        .font(.caption)
                }
            }
            
            DashedDivider()
                .padding(.vertical, 10)
            
        }
        
        
    }
}

