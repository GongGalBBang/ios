//
//  LandmarkRow.swift
//  Tutorial-0331
//
//  Created by 김택현 on 2022/04/03.
//

import SwiftUI

struct PlaceRow: View {
    var place: Place
    
    var body: some View {
        HStack {
            place.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(place.name)
            
            Spacer()
            
            if place.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
    }
}

struct LandmarkRow_Previews: PreviewProvider {
    static var places = ModelData().places
    static var previews: some View {
        Group {
            PlaceRow(place: places[0])
            PlaceRow(place: places[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
