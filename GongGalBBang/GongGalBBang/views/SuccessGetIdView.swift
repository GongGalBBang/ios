//
//  SuccessGetId.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/06/16.
//

import SwiftUI

struct SuccessGetIdView: View{
    var accountRes : AccountResult
    var parent : FindIdView
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("아이디")
                .fontWeight(.bold)
                .padding(.bottom,10)
                .padding(.top,20)
                
            Text(accountRes.result!)
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.leading)
                .foregroundColor(.black)
                .padding(.bottom,30)
            Spacer()
            Button(action: {
                parent.getBack()
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("로그인 하러가기")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .font(.system(size: 17))
            }
            .buttonStyle(SignUpStyle())
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

struct SuccessGetIdView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessGetIdView(accountRes: AccountResult(statusCode: 200, result: "admin"), parent: FindIdView(parent: AccountView()))
    }
}
