//
//  BusinessRow.swift
//  City Sights App
//
//  Created by Marco Lau on 25/08/2021.
//

import SwiftUI

struct BusinessRow: View {
    var business: Business
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("")
                
                VStack(alignment: .leading) {
                    Text(business.name ??  "")
                    Text(String(business.distance ?? 0))
                }
                
                Spacer()
                
                VStack {
                    // Rating
                    
                    // Number of ratings
                }
            }
            
            Divider()
            
        }
        
        
    }
}
