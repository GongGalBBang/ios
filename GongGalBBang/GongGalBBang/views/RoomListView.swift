//
//  MainView.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/04/14.
//

import SwiftUI

struct RoomListView: View {
    @State private var showFavoritesOnly = false
    
    @StateObject private var getRoomL = GetRoom()
    
//    var filteredLandmarks: [Place] {
//        modelData.places.filter { place in
//            (!showFavoritesOnly || place.isFavorite)
//        }
//    }
    
    init() {
        UITableView.appearance().backgroundColor = .white
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Divider()
                List{
                    Toggle(isOn: $showFavoritesOnly) {
                        Text("Favorites only")
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
                }
                .edgesIgnoringSafeArea(.all)
                .navigationTitle("ROOM LIST")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .onAppear {
            let req = RoomRequest(access_time: "2022-06-03_03:27:32", club_number: "2,3", major_number: "1,2")
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
            RoomListView().environmentObject(GetRoom())
        }
}
