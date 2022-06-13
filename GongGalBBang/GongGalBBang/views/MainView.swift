//
//  MainView.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/04/23.
//

import SwiftUI

struct MainView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var STATE: Int? = 0
    @Binding var user: LoginResult
//    var getRoom = GetRoom()
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: LogInView() .navigationBarHidden(true), tag: 1, selection: $STATE) {
                    EmptyView()
                }
                TabView {
                    RoomListView()
//                        .environmentObject(getRoom)
                        .tabItem{
                            Image(systemName: "list.dash")
                            Text("휴게 시설")
                        }.navigationBarHidden(true)
                        .navigationTitle("")
                    VStack(alignment:.leading){
                        Divider()
                        Button(action: {STATE = 1}) {
                            Text("로그아웃")
                                .foregroundColor(.black)
                                .font(.system(size: 18, weight: .light))
                        }
                        .padding(EdgeInsets(top: 20, leading: 15, bottom: 0, trailing: 0))
                        Button(action: {STATE = 1}) {
                            Text("회원탈퇴")
                                .foregroundColor(.black)
                                .font(.system(size: 18, weight: .light))
                        }
                        .padding(EdgeInsets(top: 20, leading: 15, bottom: 0, trailing: 0))
                        Spacer()
                        
                    }
                    .tabItem{
                        Image(systemName: "gearshape.fill")
                        Text("마이페이지")
                    }
                    .navigationBarHidden(true)
                    .navigationTitle("")
                    .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(user: .constant(LoginResult(statusCode: 1, result: Result(name: "박춘해", club: "[5]", major: "[2]"))))
    }
}
