//
//  LandmarkDetail.swift
//  Landmark
//
//  Created by 김택현 on 2022/04/07.
//

import SwiftUI

struct PlaceDetail: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.presentationMode) var presentationMode
    var place: Place
    
    var placeIndex: Int {
        modelData.places.firstIndex(where: {$0.id == place.id})!
    }
    
    var body: some View {
        HStack {
            Spacer()
            NavigationView {
                VStack(alignment: .leading) {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }){
                            Image(systemName: "arrowshape.turn.up.backward.fill")
                                .foregroundColor(.black)
                                .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 25))
                        }
                        Spacer()
                        // title
                        Text("Room Name")
                            .foregroundColor(.black)
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                        Spacer()
                    }
                    Divider()
                    
                    Text("시간대 별 인원 추이")
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 0))
                .navigationBarHidden(true)
            }
            Spacer()
        }
//        ScrollView{
//            MapView(coordinate: place.locationCoordinate)
//                .ignoresSafeArea(edges:.top)
//                .frame(height:300)
//            CircleImage(image: landmark.image)
//                .offset(y:-130)
//                .padding(.bottom, -130)
//            VStack(alignment: .leading) {
//                Text(landmark.name)
//                    .font(.title)
//                HStack{
//                    Text(landmark.park)
//                        .font(.subheadline)
//                    Spacer()
//                    Text(landmark.state)
//                        .font(.subheadline)
//                }
//                .font(.subheadline)
//                .foregroundColor(.secondary)
//                Divider()
//                Text("About \(landmark.name)")
//                    .font(.title2)
//                Text(landmark.description)
//            }
//            .padding()
//            .navigationTitle(landmark.name)
//            .navigationBarTitleDisplayMode(.inline)
//        }
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    static let modelData = ModelData()
    static var previews: some View {
        PlaceDetail(place: ModelData().places[0])
            .environmentObject(modelData)
    }
}