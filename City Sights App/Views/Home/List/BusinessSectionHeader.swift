//
//  BusinessSectionHeader.swift
//  City Sights App
//
//  Created by Marco Lau on 25/08/2021.
//

import SwiftUI

struct BusinessSectionHeader: View {
    var title: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(.white)
            
            Text(title)
                .bold()
        }
    }
}
