//
//  TutorialMainView.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/06/17.
//

import SwiftUI

struct TutorialMainView: View {
    @State var STATE: Int? = 0
    
    @State private var showFavoritesOnly = false
    @State private var res : [RoomResult]
    @State var STATER: Int? = 0
    @State private var color = Color.white
    @State private var showing = false
    @State private var secondColor = Color.white
    @State private var secondShowing = false
    @State private var lastColor = Color.white
    @State private var flag = false
    
    init() {
        res = [RoomResult(className: 101, data: [Datee(date: "10", member: 1.1),Datee(date: "11", member: 3.1),Datee(date: "12", member: 2.1), Datee(date: "13", member: 5.1), Datee(date: "14", member: 6.1), Datee(date: "15", member: 9.1), Datee(date: "16", member: 4.1), Datee(date: "17", member: 6.1), Datee(date: "18", member: 4.1), Datee(date: "19", member: 3.1), Datee(date: "20", member: 5.1), Datee(date: "21", member: 8.1)]),
               RoomResult(className: 200, data: [Datee(date: "10", member: 1.1),Datee(date: "11", member: 3.1),Datee(date: "12", member: 2.1), Datee(date: "13", member: 5.1), Datee(date: "14", member: 6.1), Datee(date: "15", member: 9.1), Datee(date: "16", member: 4.1), Datee(date: "17", member: 6.1), Datee(date: "18", member: 4.1), Datee(date: "19", member: 3.1), Datee(date: "20", member: 5.1), Datee(date: "21", member: 8.1)]),
               RoomResult(className: 201, data: [Datee(date: "10", member: 1.1),Datee(date: "11", member: 3.1),Datee(date: "12", member: 2.1), Datee(date: "13", member: 5.1), Datee(date: "14", member: 6.1), Datee(date: "15", member: 9.1), Datee(date: "16", member: 4.1), Datee(date: "17", member: 6.1), Datee(date: "18", member: 4.1), Datee(date: "19", member: 3.1), Datee(date: "20", member: 5.1), Datee(date: "21", member: 8.1)]),
               RoomResult(className: 202, data: [Datee(date: "10", member: 1.1),Datee(date: "11", member: 3.1),Datee(date: "12", member: 2.1), Datee(date: "13", member: 5.1), Datee(date: "14", member: 6.1), Datee(date: "15", member: 9.1), Datee(date: "16", member: 4.1), Datee(date: "17", member: 6.1), Datee(date: "18", member: 4.1), Datee(date: "19", member: 3.1), Datee(date: "20", member: 5.1), Datee(date: "21", member: 8.1)]),
               RoomResult(className: 203, data: [Datee(date: "10", member: 1.1),Datee(date: "11", member: 3.1),Datee(date: "12", member: 2.1), Datee(date: "13", member: 5.1), Datee(date: "14", member: 6.1), Datee(date: "15", member: 9.1), Datee(date: "16", member: 4.1), Datee(date: "17", member: 6.1), Datee(date: "18", member: 4.1), Datee(date: "19", member: 3.1), Datee(date: "20", member: 5.1), Datee(date: "21", member: 8.1)])]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Divider()
                    List{
                        Toggle(isOn: $showFavoritesOnly) {
                            Text("원하는 방만 보기")
                                .fontWeight(.bold)
                        }
                        ForEach(res, id: \.self) { room in
                            let name = getRoomName(room:room)
                            let isSet = UserDefaults.standard.bool(forKey: name)
                            NavigationLink {
                                TutorialRoomDetail(room: room).navigationBarHidden(true)
                            } label: {
                                PlaceRow(room: room, isSet: isSet)
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
                }
                Text("방 목록에서는 과방과\n동아리방 목록을 확인할 수 있어요")
                    .fontWeight(.bold)
                    .frame(width: 280, height: 120)
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
                    secondShowing.toggle()
                    showing.toggle()
                }
                       ,label: {Image(systemName: "arrow.right")
                        .resizable()
                        .foregroundColor(self.showing ? .white : .clear)
                        .colorMultiply(self.secondColor)
                        .frame(width: 15, height: 15)
                        .animation(.easeInOut(duration: 2), value: showing)
                })
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 20))
                .offset(x: 130, y:-250)
                
                Text("원하는 방을 클릭해보세요")
                    .fontWeight(.bold)
                    .frame(width: 280, height: 120)
                    .multilineTextAlignment(.center)
                    .colorMultiply(self.lastColor)
                    .background(self.secondShowing ? .cyan : .clear)
                    .foregroundColor(self.secondShowing ? .white : .clear)
                    .cornerRadius(12)
                    .offset(x: 0, y:100)
                    .animation(.easeInOut(duration: 1), value: secondShowing)
            }
            .navigationTitle("방 목록")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                }
                UITableView.appearance().backgroundColor = .white
            }
        }
    }
}

struct TutorialMainView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialMainView()
//        TutorialMainView(user: .constant(LoginResult(statusCode: 1, result: Result(name: "박춘해", club: "[5]", major: "[2]"))))
    }
}
