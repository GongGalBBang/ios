//
//  LandmarkRow.swift
//  Tutorial-0331
//
//  Created by 김택현 on 2022/04/03.
//

import SwiftUI

struct PlaceRow: View {
    var room: RoomResult
    let isSet: Bool
    
    var body: some View {
        let name = getRoomName(room:room)
        HStack {
            Image(name)
                .resizable()
                .frame(width: 50, height: 50)
            VStack(alignment: .leading){
                Text(getRoomName(room:room))
            }
            
            Spacer()
            
            if isSet {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
    }
}

struct PlaceRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlaceRow(room: RoomResult(className: 101, data: [Datee(date: "10", member: 3), Datee(date: "11", member: 4)]), isSet: true)
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
