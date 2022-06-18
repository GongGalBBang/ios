//
//  FindIdView.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/06/16.
//

import SwiftUI
import ExytePopupView
import AnyFormatKitSwiftUI

struct FindIdView: View{
    @State var fullName = ""
    @State var tmpPhoneNumber = ""
    @State var STATE : Int? = 0
    
    @State var showingToast = false
    @State var showingToastTitle = ""
    @State var showingToastMessage = ""
    
    @StateObject private var postAccount = PostAccount()
    @Environment(\.presentationMode) var presentationMode
    
    var parent : AccountView
    
    func getBack() {
        parent.getBack()
        presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View{
        NavigationView {
            VStack {
                NavigationLink(destination: SuccessGetIdView(accountRes: postAccount.res, parent: self).navigationBarHidden(true), tag: 1, selection: $STATE) {
                    EmptyView()
                    
                }
                VStack(alignment: .leading) {
                    Text("정보를 입력해주세요.")
                        .padding(.bottom,20)
                        .padding(.top,20)
                    // full name
                    Text("이름")
                        .foregroundColor(.black)
                    TextField("Enter your Full Name", text: $fullName)
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.black)
                    
                    // phone
                    Text("전화번호")
                        .foregroundColor(.black)
                        .padding(.top, 10)
                    FormatTextField(
                        unformattedText: $tmpPhoneNumber, placeholder: "Enter your Phone Number",
                        textPattern: "###-####-####"
                    )
                    .padding(.bottom, 20)
                }
            
                Spacer()
                Button(action: {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                        if(fullName == "" || tmpPhoneNumber == "") {
                            showingToast = true
                            showingToastTitle = "오류"
                            showingToastMessage = "모든 정보를 입력해주세요"
                        }
                        else if(!isValidName(testStr: fullName)) {
                            showingToast = true
                            showingToastTitle = "이름 오류"
                            showingToastMessage = "올바른 이름 형식을 입력해주세요"
                        }
                        else if(!isValidPhoneNumber(testStr: tmpPhoneNumber)) {
                            showingToast = true
                            showingToastTitle = "전화번호 오류"
                            showingToastMessage = "올바른 전화번호를 입력해주세요"
                        }
                        else {
                            let phoneNumber = phoneformat(num: tmpPhoneNumber)
                            let req = AccountRequest(function_case: 0, phoneNumber: phoneNumber, user_name: fullName)
                            
                            postAccount.postAccount(accountReq: req)
                            
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                                if(postAccount.res.statusCode == 200) {
                                    STATE = 1
                                }
                                else if(postAccount.res.statusCode == 403) {
                                    showingToast = true
                                    showingToastTitle = "아이디 찾기 오류"
                                    showingToastMessage = "존재하지 않는 계정입니다"
                                }
                            }
                        }
                    }
                }){
                    Text("아이디 찾기")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .font(.system(size: 17))
                }
                    .buttonStyle(SignUpStyle())
                
                Spacer()
                Spacer()
            }
            .popup(isPresented: $showingToast, type: .floater(verticalPadding: 20), position: .bottom, animation: .spring(), autohideIn: 2, closeOnTap: true, closeOnTapOutside: true, view: {
                createBottomToastMessage(title: showingToastTitle, message: showingToastMessage)
            })
            .navigationBarHidden(true)
        }
    }
}


struct FindIdView_Previews: PreviewProvider {
    static var previews: some View {
        FindIdView(parent: AccountView())
    }
}
