//
//  BusinessTitle.swift
//  City Sights App
//
//  Created by Marco Lau on 27/08/2021.
//

import SwiftUI

struct BusinessTitle: View {
    var business: Business
    
    var body: some View {
        VStack (alignment: .leading, spacing: 15) {
            // Business name
            Text(business.name ?? "")
                .bold()
                .font(.title)
            
            // Address and Yelp image
//                if business.location != nil {
//                    VStack(alignment: .leading, spacing: 5) {
//                        Text("\(business.location!.address1!), \(business.location!.city!)")
//                            .font(.caption)
//                        Text("\(business.location!.state!), \(business.location!.country!)")
//                            .font(.caption)
//                    }
//                }
            
            // Address doesn't show, because displayAddress always seem to be nil, although it really isn't
            if business.location?.displayAddress != nil {
                ForEach(business.location!.displayAddress!, id: \.self) { line in
                    Text(line)
                        .font(.caption)
                }
            }
            
            // Rating
            Image("regular_\(business.rating ?? 0.0)")
            
        }
    }
}


