//
//  SuccessChangePwView.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/06/16.
//

import SwiftUI

struct SuccessChangePwView: View {
    var req : AccountRequest
    var parent : ChangePwReqView
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Text(req.user_name)
                    .fontWeight(.bold)
                Text("님의 비밀번호 변경이 완료되었습니다.")
            }
                .padding(.top,20)
                .padding(.bottom,20)
            
            Spacer()
            
            Button(action: {
                parent.getBack()
                presentationMode.wrappedValue.dismiss()
            }){
                Text("로그인하러 가기")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .font(.system(size: 17))
            }
            .buttonStyle(SignUpStyle())
            Spacer()
        }
    }
}

struct SuccessChangePwView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessChangePwView(req: AccountRequest(function_case: 0, user_name: "김택현"), parent: ChangePwReqView(req: AccountRequest(function_case: 0, user_name: "김택현"), parent: ChangePwView(parent: AccountView())))
    }
}
