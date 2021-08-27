//
//  Common.swift
//  City Sights App
//
//  Created by Marco Lau on 27/08/2021.
//

import SwiftUI

struct Yelp: View {
    var link: String
    
    var body: some View {
        Link(destination: URL(string: link)!, label: {
            Image("yelp")
                .resizable()
                .scaledToFit()
                .frame(height: 36)
        })
    }
}
