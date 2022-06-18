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
    
    func getBack() {
        presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        NavigationView {
            TabView {
                RoomListView(major: user.result!.major, club: user.result!.club)
                    .tabItem{
                        Image(systemName: "list.dash")
                        Text("방 목록")
                    }
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                
                MypageView(parent: self)
                    .tabItem{
                        Image(systemName: "gearshape.fill")
                        Text("마이페이지")
                    }
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
            }
            .onAppear() {
                UITabBar.appearance().barTintColor = .white
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(user: .constant(LoginResult(statusCode: 1, result: Result(name: "박춘해", club: "[5]", major: "[2]"))))
    }
}
