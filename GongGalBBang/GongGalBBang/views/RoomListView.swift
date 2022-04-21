//
//  MainView.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/04/14.
//

import SwiftUI

struct RoomListView: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showFavoritesOnly = false
    @Environment(\.presentationMode) var presentationMode
    
    var filteredLandmarks: [Place] {
        modelData.places.filter { place in
            (!showFavoritesOnly || place.isFavorite)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List{
                    Toggle(isOn: $showFavoritesOnly) {
                        Text("Favorites only")
                    }
                    ForEach(filteredLandmarks, id: \.id) { place in
                        NavigationLink {
                            PlaceDetail(place: place)
                        } label: {
                            PlaceRow(place: place)
                        }
                    }
                }
            }
            .navigationTitle("ROOM LIST")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    },label: {Image(systemName: "xmark")
                        .foregroundColor(.black)
                    })
                }
            })
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
                RoomListView().environmentObject(ModelData())
        }
}