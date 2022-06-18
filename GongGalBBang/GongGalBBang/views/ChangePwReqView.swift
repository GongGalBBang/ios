//
//  ChangePwReqView.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/06/16.
//

import SwiftUI

struct ChangePwReqView: View {
    @State var STATE : Int? = 0
    @State var req : AccountRequest
    @State var password = ""
    @StateObject private var postAccount = PostAccount()
    
    @State var showingToast = false
    @State var showingToastTitle = ""
    @State var showingToastMessage = ""
    
    var parent : ChangePwView
    
    @Environment(\.presentationMode) var presentationMode
    
    func getBack() {
        parent.getBack()
        presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        VStack {
            NavigationLink(destination: SuccessChangePwView(req: req, parent: self).navigationBarHidden(true), tag: 1, selection: $STATE) {
                EmptyView()
            }
            HStack {
                Text(req.user_name)
                    .fontWeight(.bold)
                Text("님 안녕하세요.")
            }
            .padding(EdgeInsets(top: 20, leading: 0, bottom: 1, trailing: 0))

            Text("변경하실 비밀번호를 입력해주세요.")
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
            // password
            VStack(alignment: .leading) {
                Text("비밀번호")
                    .foregroundColor(.black)
                    .padding(.top, 10)
                SecureField("Must be at least 6 characters", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
            }
            .padding(.bottom, 20)
            
            Spacer()
            
            Button(action: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    if(!isValidPassword(testStr: password)) {
                        showingToast = true
                        showingToastTitle = "전화번호 오류"
                        showingToastMessage = "올바른 전화번호를 입력해주세요"
                    }
                    else {
                        req.change_pw = password
                        postAccount.postAccount(accountReq: req)
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                            if(postAccount.res.statusCode == 200) {
                                STATE = 1
                            }
                            else if(postAccount.res.statusCode == 403) {
                                showingToast = true
                                showingToastTitle = "비밀번호 변경 오류"
                                showingToastMessage = "다시 시도해 주세요"
                            }
                        }
                    }
                }
            }){
                Text("비밀번호 변경하기")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .font(.system(size: 17))
            }
                .buttonStyle(SignUpStyle())
            Spacer()
        }
    }
}

struct ChangePwReqView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePwReqView(req: AccountRequest(function_case: 0, user_name: "김택현"), parent: ChangePwView(parent: AccountView()))
    }
}
