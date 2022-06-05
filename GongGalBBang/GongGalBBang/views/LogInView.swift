//
//  ContentView.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/04/07.
//

import SwiftUI

struct LogInView: View {
    @State var emailAddress = ""
    @State var password = ""
    @State var STATE: Int? = 0
    @State var showingToast = false
    @State var showingToastTitle = ""
    @State var showingToastMessage = ""
    var body: some View {
        NavigationView{
            ZStack {
                HStack {
                    Spacer()
                    Spacer()
                    VStack{
                        NavigationLink(destination: MainView() .navigationBarHidden(true), tag: 1, selection: $STATE) {
                            EmptyView()
                        }
                        NavigationLink(destination: SignUpView()
                            .navigationBarHidden(true),  tag: 2, selection: $STATE) {
                            EmptyView()
                        }
                        
                        Image("GongGalBBang")
                            .resizable()
                            .edgesIgnoringSafeArea(.all)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200)
                            .padding()
                        
                        VStack(alignment: .leading) {
                            Text("Email address")
                            TextField("Enter your Email address", text: $emailAddress)
                                .textFieldStyle(.roundedBorder)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Password")
                            SecureField("Enter your Password", text: $password)
                                .textFieldStyle(.roundedBorder)
                        }
                        Button(action: {
                            if(emailAddress == "" || password == "") {
                                self.showingToast = true
                                self.showingToastTitle = "오류"
                                self.showingToastMessage = "모든 정보를 입력해주세요"
                            }
                            else if(!isValidEmail(testStr: emailAddress)) {
                                self.showingToast = true
                                self.showingToastTitle = "이메일 오류"
                                self.showingToastMessage = "올바른 이메일 형식을 입력해주세요"
                            }
                            else if(!isValidPassword(testStr: password)){
                                self.showingToast = true
                                self.showingToastTitle = "비밀번호 오류"
                                self.showingToastMessage = "올바른 비밀번호 형식을 입력해주세요"
                            }
                            else {
                                STATE = 1
                            } }) {
                            Text("Log In")
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                                .font(.title3)
                        }
                            .buttonStyle(LoginStyle())
                            .padding()
                        
                        Button(action: {STATE = 2}) {
                            Text("Don't have account? Sign Up")
                                .fontWeight(.light)
                        }
                        Spacer()
                    }
                    Spacer()
                    Spacer()
                }
            }
            .popup(isPresented: $showingToast, type: .floater(verticalPadding: 20), position: .bottom, animation: .spring(), autohideIn: 2, closeOnTap: true, closeOnTapOutside: true, view: {
                createBottomToastMessage(title: self.showingToastTitle, message: self.showingToastMessage)
            })
            .navigationTitle("Log In")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
