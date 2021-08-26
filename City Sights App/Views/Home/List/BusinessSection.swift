//
//  BusinessSection.swift
//  City Sights App
//
//  Created by Marco Lau on 25/08/2021.
//

import SwiftUI

struct BusinessSection: View {
    var title: String
    var businessList: [Business]
    
    var body: some View {
        Section (header: BusinessSectionHeader(title: title))  {
            ForEach(businessList) { business in
                
                NavigationLink(
                    destination: BusinessDetailView(business: business),
                    label: {
                        BusinessRow(business: business)
                    })
                    .accentColor(.black)
                
               
            }
        }
    }
}


