//
//  MypageView.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/06/18.
//

import SwiftUI

struct MypageView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var STATE: Int? = 0
    var parent: MainView
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                Divider()
                    .padding(.top, 91)
                Button(action: {
                    parent.getBack()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("로그아웃")
                        .foregroundColor(.black)
                        .font(.system(size: 17, weight: .light))
                }
                .padding(EdgeInsets(top: 25, leading: 20, bottom: 0, trailing: 0))
                Button(action: {STATE = 1}) {
                    Text("회원탈퇴")
                        .foregroundColor(.black)
                        .font(.system(size: 17, weight: .light))
                }
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 0))
                Spacer()
            }
            .edgesIgnoringSafeArea(.top)
            .navigationTitle("마이페이지")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MypageView_Previews: PreviewProvider {
    static var previews: some View {
        MypageView(parent: MainView(user: .constant(LoginResult(statusCode: 1, result: Result(name: "박춘해", club: "[5]", major: "[2]")))))
    }
}
