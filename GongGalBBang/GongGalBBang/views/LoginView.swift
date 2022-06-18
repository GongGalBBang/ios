//
//  ContentView.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/04/07.
//

import SwiftUI

struct LoginView: View {
    @State var emailAddress = ""
    @State var password = ""
    @State var STATE: Int? = 0
    @State var showingToast = false
    @State var showingToastTitle = ""
    @State var showingToastMessage = ""
    @ObservedObject var res = LoginParameter()
    
    @StateObject private var postLogin = PostLogin()
    
    var body: some View {
        NavigationView{
            VStack {
                NavigationLink(destination: MainView(user: self.$res.res)
                    .navigationBarHidden(true), tag: 1, selection: $STATE) {
                    EmptyView()
                }
                NavigationLink(destination: SignUpView(clubSelectedItems: [], majorSelectedItems: [])
                    .navigationBarHidden(true),  tag: 2, selection: $STATE) {
                    EmptyView()
                }
                NavigationLink(destination: AccountView()
                    .navigationBarHidden(true),  tag: 3, selection: $STATE) {
                    EmptyView()
                }
                Divider()
                    .padding(.top, 91)
                HStack {
                    Spacer()
                    Spacer()
                    VStack{
                        Image("GongGalBBangLogo")
                            .resizable()
                            .edgesIgnoringSafeArea(.all)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200)
                            .padding()
                        
                        VStack(alignment: .leading) {
                            Text("이메일")
                            TextField("Enter your Email address", text: $emailAddress)
                                .textFieldStyle(.roundedBorder)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("비밀번호")
                            SecureField("Enter your Password", text: $password)
                                .textFieldStyle(.roundedBorder)
                        }
                        Button(action: {
                            UserDefaults.standard.set(false, forKey: "tutorial")
                            if(emailAddress == "" || password == "") {
                                showingToast = true
                                showingToastTitle = "오류"
                                showingToastMessage = "모든 정보를 입력해주세요"
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
                            else {
                                let req = LoginRequest(user_id : emailAddress, user_pw : password)
                                postLogin.postUser(loginReq: req)
                                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                                    if(postLogin.res.statusCode == 200) {
                                    res.res = postLogin.res
                                    STATE = 1
                                    }
                                    else {
                                        showingToast = true
                                        showingToastTitle = "로그인 실패"
                                        showingToastMessage = "다시 입력해주세요"
                                    }
                                }
                            }
                        }) {
                            Text("로그인하기")
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                                .font(.title3)
                        }
                            .buttonStyle(LoginStyle())
                            .padding(EdgeInsets(top: 40, leading: 0, bottom: 5, trailing: 0))
                        
                        Button(action: {STATE = 3}) {
                            Text("아이디 / 비밀번호 찾기")
                                .fontWeight(.light)
                                .foregroundColor(.gray)
                                .font(.system(size:15))
                        }
                        
                        Divider()
                        
                        Button(action: {STATE = 2}) {
                            Text("계정이 없으신가요? 가입하기")
                                .fontWeight(.light)
                        }
                    }
                }
                Spacer()
            }
            .popup(isPresented: $showingToast, type: .floater(verticalPadding: 20), position: .bottom, animation: .spring(), autohideIn: 2, closeOnTap: true, closeOnTapOutside: true, view: {
                createBottomToastMessage(title: showingToastTitle, message: showingToastMessage)
            })
            .edgesIgnoringSafeArea(.all)
            .navigationTitle("로그인")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
