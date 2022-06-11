//
//  LandmarkRow.swift
//  Tutorial-0331
//
//  Created by 김택현 on 2022/04/03.
//

import SwiftUI

struct PlaceRow: View {
    var room: RoomResult
    
    var body: some View {
        HStack {
//            place.image
//                .resizable()
//                .frame(width: 50, height: 50)
            VStack(alignment: .leading){
                Text("\(room.className)호")
            }
            
            Spacer()
            
//            if place.isFavorite {
//                Image(systemName: "star.fill")
//                    .foregroundColor(.yellow)
//            }
        }
    }
}

struct PlaceRow_Previews: PreviewProvider {
    static var room = GetRoom().res
    static var previews: some View {
        Group {
            PlaceRow(room: room[0])
            PlaceRow(room: room[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
