//
//  BusinessList.swift
//  City Sights App
//
//  Created by Marco Lau on 25/08/2021.
//

import SwiftUI

struct BusinessList: View {
    @EnvironmentObject var model: ContentModel
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, pinnedViews: .sectionHeaders) {
                
                BusinessSection(title: "Restauants", businessList: model.restaurants)
                
                BusinessSection(title: "Sights", businessList: model.sights)
                
            }
            .padding(.horizontal)
        }
    }
}

struct BusinessList_Previews: PreviewProvider {
    static var previews: some View {
        BusinessList()
    }
}
