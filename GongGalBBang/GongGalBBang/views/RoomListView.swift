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
    
//    var filteredLandmarks: [Place] {
//        modelData.places.filter { place in
//            (!showFavoritesOnly || place.isFavorite)
//        }
//    }
    
    var body: some View {
        NavigationView {
            VStack {
                Divider()
                List{
                    Toggle(isOn: $showFavoritesOnly) {
                        Text("원하는 방만 보기")
                            .fontWeight(.bold)
                    }
                    ForEach(getRoomL.res, id: \.self) { room in
                        NavigationLink {
                            PlaceDetail(room: room).navigationBarHidden(true)
                        } label: {
                            PlaceRow(room: room)
                        }
                    }
//                    ForEach(filteredLandmarks, id: \.id) { place in
//                        NavigationLink {
//                            PlaceDetail(place: place).navigationBarHidden(true)
//                        } label: {
//                            PlaceRow(place: place)
//                        }
//                    }
                    Spacer()
                }
                .edgesIgnoringSafeArea(.all)
                .navigationTitle("방 목록")
                .navigationBarTitleDisplayMode(.inline)
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

//
//        VStack {
//            Button(action: {
//                print("room tapped!")
//            }) {
//                Text("휴게 공간 확인하기")
//                    .foregroundColor(.black)
//                    .fontWeight(.semibold)
//                    .font(.system(size: 17))
//                    .frame(width: 150, height: 20, alignment: .center)
//            }
//            .buttonStyle(LoginStyle())
//            .padding()
//
//            Button(action: {
//                print("mypage tapped!")
//            }) {
//                Text("마이페이지")
//                    .foregroundColor(.black)
//                    .fontWeight(.semibold)
//                    .font(.system(size: 17))
//                    .frame(width: 150, height: 20, alignment: .center)
//            }
//            .buttonStyle(LoginStyle())
//            .padding()
//        }


struct RoomListViewView_Previews:
    PreviewProvider {
        static var previews: some View {
            RoomListView(major: "1", club: "1").environmentObject(GetRoom())
        }
}
