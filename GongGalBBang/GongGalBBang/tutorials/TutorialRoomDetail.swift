//
//  TutorialRoomDetail.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/06/18.
//

import SwiftUI
import Foundation

struct TutorialRoomDetail: View {
    @EnvironmentObject var getRoom: GetRoom
    @State private var color = Color.white
    @State private var showing = false
    @State private var secondColor = Color.white
    @State private var secondShowing = false
    var room: RoomResult
    @State var STATE: Int? = 0
    
    var roomIndex: Int {
        getRoom.res.firstIndex(where: {$0.className == room.className})!
    }
    
    
    var body: some View {
        let name = getRoomName(room:room)
        
        NavigationView {
            ZStack {
                VStack{
                    NavigationLink(destination: LoginView().navigationBarHidden(true), tag: 1, selection: $STATE) {
                        EmptyView()
                    }
                    Image(name).resizable().frame(width: 200, height: 200)
                    HStack {
                        Text(name)
                            .font(.body)
    //                        FavoriteButton(isSet: $getRoom.rooms[roomIndex].isFavorite)
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    
                    let hour = getHour()
                    let confuse = getConfuse(date: room.data, time: hour)
                                   
                    HStack {
                        Text("현재 \(hour)시 혼잡도: ")
                        Text(confuse).foregroundColor(getConfuseColor(confuse: confuse))
                    }
                    
                    Divider()
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                    
                    Text("시간대 별 인원 추이")
                        .fontWeight(.bold)
                        .frame(alignment: .leading)
                    VStack {
                        Text("그래프")
                            .font(.body)
                        LineChartView(date: room.data)
                    }.frame(width: .infinity, height: 250)
                    .foregroundColor(.black)
                    Spacer()
                }
                Text("그래프를 통해 시간대별 인원수와\n현재 시간 예상 혼잡도를 확인할 수 있어요")
                    .fontWeight(.bold)
                    .frame(width: 300, height: 120)
                    .multilineTextAlignment(.center)
                    .background(self.showing ? .cyan : .clear)
                    .colorMultiply(self.color)
                    .foregroundColor(self.showing ? .white : .clear)
                    .cornerRadius(12)
                    .offset(x: 0, y:-200)
                    .onAppear() {
                        withAnimation(.easeInOut(duration: 1)) {
                            self.showing = true
                            self.color = Color.white
                            
                        }
                    }
                Button(action: {
                    self.showing = false
                    self.secondShowing = true
                    self.secondColor = Color.white
                }
                       ,label: {Image(systemName: "arrow.right")
                        .resizable()
                        .foregroundColor(self.showing ? .white : .clear)
                        .colorMultiply(self.color)
                        .frame(width: 15, height: 15)
                        .animation(.easeInOut(duration: 2), value: showing)
                })
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 20))
                .offset(x: 140, y:-250)
                
                Text("시작할까요?")
                    .fontWeight(.bold)
                    .frame(width: 280, height: 120)
                    .multilineTextAlignment(.center)
                    .background(self.secondShowing ? .cyan : .clear)
                    .colorMultiply(self.secondColor)
                    .foregroundColor(self.secondShowing ? .white : .clear)
                    .cornerRadius(12)
                    .offset(x: 0, y:-200)
                    .animation(.easeInOut(duration: 1), value: secondShowing)
                
                Button(action: {
                    UserDefaults.standard.set(true, forKey: "tutorial")
                    STATE = 1
                }){
                    Text("GO")
                        .fontWeight(.bold)
                        .foregroundColor(self.secondShowing ? .white : .clear)
                        .colorMultiply(self.secondColor)
                        .animation(.easeInOut(duration: 2), value: secondShowing)
                }
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 20))
                .offset(x: 120, y:-170)
            }
            .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(name)
        }
    }
}
struct TutorialRoomDetail_Previews: PreviewProvider {
    static var previews: some View {
        TutorialRoomDetail(room: RoomResult(className: 101, data: [Datee(date: "10", member: 3), Datee(date: "11", member: 4), Datee(date: "12", member: 3), Datee(date: "13", member: 6), Datee(date: "14", member: 8), Datee(date: "15", member: 10)]))
    }
}
