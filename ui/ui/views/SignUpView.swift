//
//  SignUpView.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/04/14.
//

import SwiftUI
import ExytePopupView

struct SignUpView: View {
    @State var fullName = ""
    @State var emailAddress = ""
    @State var password = ""
    @State var emailUpdate = false
    @Environment(\.presentationMode) var presentationMode
    @State var STATE: Int? = 0
    @State var showingToast = false
    @State var showingToastTitle = ""
    @State var showingToastMessage = ""
    
    var body: some View {
        NavigationView {
            HStack {
                Spacer()
                Spacer()
                ZStack {
                    VStack {
                        NavigationLink(destination: MainView().navigationBarHidden(true), tag: 1, selection: $STATE) {
                            EmptyView()
                        }
                        
                        // full name
                        VStack(alignment: .leading) {
                            Text("Full Name")
                                .foregroundColor(.black)
                            TextField("Enter your Full Name", text: $fullName)
                                .textFieldStyle(.roundedBorder)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.black)
                        }
                        
                        // email
                        VStack(alignment: .leading) {
                            Text("Email")
                                .foregroundColor(.black)
                            TextField("Enter your Email", text: $emailAddress)
                                .textFieldStyle(.roundedBorder)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.black)
                        }
                        
                        // password
                        VStack(alignment: .leading) {
                            Text("Password")
                                .foregroundColor(.black)
                            SecureField("Must be at least 6 characters", text: $password)
                                .textFieldStyle(.roundedBorder)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.black)
                        }
                        
                        // checkbox
                        Toggle("개인정보 수집에 동의합니다.", isOn: $emailUpdate)
                            .foregroundColor(.black)
                            .font(.system(size: 15))
                            .toggleStyle(CheckboxStyle())
                            .padding()
                        
                        // sign up button
                        Button(action: {
                            if(fullName == "" || emailAddress == "" || password == "") {
                                showingToast = true
                                showingToastTitle = "오류"
                                showingToastMessage = "모든 정보를 입력해주세요"
                            }
                            else if(!isValidName(testStr: fullName)) {
                                showingToast = true
                                showingToastTitle = "이름 오류"
                                showingToastMessage = "올바른 이름 형식을 입력해주세요"
                            }
                            else if(!isValidEmail(testStr: emailAddress)) {
                                showingToast = true
                                showingToastTitle = "이메일 오류"
                                showingToastMessage = "올바른 이메일 형식을 입력해주세요"
                            }
                            else if(!isValidPassword(testStr: password)){
                                showingToast = true
                                showingToastTitle = "비밀번호 오류"
                                showingToastMessage = "올바른 비밀번호 형식을 입력해주세요"
                            }
                            else if(!emailUpdate) {
                                showingToast = true
                                showingToastTitle = "접근 오류"
                                showingToastMessage = "개인정보 수집에 동의해주세요"
                            }
                            else {
                                STATE = 1
                            }
                        }){
                            Text("SIGN UP")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .font(.system(size: 17))
                        }
                            .buttonStyle(SignUpStyle())
                        
                        Text("By continuing, you agree to accept\n our Privacy Policy & Terms of Service")
                            .foregroundColor(.black)
                            .font(.system(size: 13))
                            .fontWeight(.light)
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .popup(isPresented: $showingToast, type: .floater(verticalPadding: 20), position: .bottom, animation: .spring(), autohideIn: 2, closeOnTap: true, closeOnTapOutside: true, view: {
                    createBottomToastMessage(title: showingToastTitle, message: showingToastMessage)
                })
                Spacer()
                Spacer()
        }
                
            .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))
            .navigationTitle("SIGN UP")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    },label: {Image(systemName: "xmark")
                        .foregroundColor(.black)
                    })
                }
            })
        }
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
