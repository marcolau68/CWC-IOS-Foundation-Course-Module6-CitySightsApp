//
//  ContactRow.swift
//  City Sights App
//
//  Created by Marco Lau on 26/08/2021.
//

import SwiftUI

struct ContactRow: View {
    var via: String
    var address: String
    var keyword: String
    var url: String
    var shortAddress: String {
        if address.count > 30 {
            return String(address.prefix(30))
        }
        return address
    }
    
    var body: some View {
        HStack {
            HStack(spacing: 5) {
                Text("\(via): ")
                    .bold()
                Text("\(address)")
            }
            
            Spacer()
            
            Text(keyword)
        }
        .padding(.vertical)
        
        Divider()
    }
}


