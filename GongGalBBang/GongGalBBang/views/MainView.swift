//
//  MainView.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/04/23.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        NavigationView {
            TabView {
                RoomListView().environmentObject(ModelData())
                    .tabItem{
                        Image(systemName: "list.dash")
                        Text("휴게 시설")
                    }.navigationBarHidden(true)
                    .navigationTitle("")
                MyPageView().environmentObject(ModelData())
                    .tabItem{
                        Image(systemName: "gearshape.fill")
                        Text("마이페이지")
                    }
                    .navigationBarHidden(true)
                    .navigationTitle("")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
