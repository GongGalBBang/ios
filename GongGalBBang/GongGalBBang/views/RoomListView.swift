//
//  MainView.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/04/14.
//

import SwiftUI
import Foundation

struct RoomListView: View {
    @State private var showFavoritesOnly = false
    
    @StateObject private var getRoomL = GetRoom()
    var major : String
    var club : String
    
    @State private var starList : [String:Bool] = [:]
    
    var filteredRoom: [RoomResult] {
        getRoomL.res.filter { room in
            let name = getRoomName(room:room)
            let isSet = UserDefaults.standard.bool(forKey: name)
            return (!showFavoritesOnly || isSet)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Divider()
                List{
                    Toggle(isOn: $showFavoritesOnly) {
                        Text("원하는 방만 보기")
                            .fontWeight(.bold)
                    }
                    ForEach(filteredRoom, id: \.self) { room in
                        let name = getRoomName(room:room)
                        NavigationLink {
                            if(starList[name] != nil) {
                                PlaceDetail(room: room, star: starList[name]!).navigationBarHidden(true)
                            }
                        } label: {
                            if(starList[name] != nil) {
                                PlaceRow(room: room, isSet: starList[name]!)
                            }
                        }
                    }
                    Spacer()
                }
            }
            .navigationTitle("방 목록")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear{
                starList = getStars()
            }
        }
        .onAppear {
            UITableView.appearance().backgroundColor = .white
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let currentDate = formatter.string(from: Date())
            let req = RoomRequest(access_time: currentDate, club_number: club, major_number: major)
            print(req)
            getRoomL.getRooms(roomReq: req)
        }
    }
}

struct RoomListViewView_Previews:
    PreviewProvider {
        static var previews: some View {
            RoomListView(major: "2", club: "1").environmentObject(GetRoom())
        }
}
