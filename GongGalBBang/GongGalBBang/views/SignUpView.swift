//
//  SignUpView.swift
//  GongGalBBang
//
//  Created by 김택현 on 2022/04/14.
//

import SwiftUI
import ExytePopupView
import AnyFormatKitSwiftUI

struct SignUpView: View {
    @State var fullName = ""
    @State var emailAddress = ""
    @State var password = ""
    @State var tmpPhoneNumber = ""
    @State var emailUpdate = false
    @Environment(\.presentationMode) var presentationMode
    @State var STATE: Int? = 0
    @State var showingToast = false
    @State var showingToastTitle = ""
    @State var showingToastMessage = ""
    
    @StateObject private var postRegister = PostRegister()
    
    @State var clubSelectedItems:[Club]
    
    @State var majorSelectedItems:[Major]
    
    var body: some View {
        NavigationView {
            VStack {
                Divider()
                    .padding(.top, 91)
                HStack {
                    Spacer()
                    Spacer()
                    ZStack {
                        VStack {
                            NavigationLink(destination: LoginView().navigationBarHidden(true), tag: 1, selection: $STATE) {
                                EmptyView()
                            }
                            
                            // full name
                            VStack(alignment: .leading) {
                                Text("이름")
                                    .foregroundColor(.black)
                                    .padding(.top, 20)
                                TextField("Enter your Full Name", text: $fullName)
                                    .textFieldStyle(.roundedBorder)
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.black)
                            // email
                                Text("이메일")
                                    .foregroundColor(.black)
                                    .padding(.top, 10)
                                TextField("Enter your Email", text: $emailAddress)
                                    .autocapitalization(.none)
                                    .textFieldStyle(.roundedBorder)
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.black)
                                // password
                                Text("비밀번호")
                                    .foregroundColor(.black)
                                    .padding(.top, 10)
                                SecureField("Must be at least 6 characters", text: $password)
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
                                .keyboardType(.decimalPad)
                                .padding(.bottom, 20)
                            }
                            
                            NavigationLink(destination: {
                                MajorSelectPickerView( selectedItems: $majorSelectedItems)
                            }, label: {
                                HStack {
                                    Text("소속")
                                        .foregroundColor(.black)
                                    Spacer()
                                    Image(systemName: "\(majorSelectedItems.count).circle")
                                        .foregroundColor(.black)
                                        .font(.title2)
                                }
                            }).padding(.vertical)
                            
                            NavigationLink(destination: {
                                ClubSelectPickerView( selectedItems: $clubSelectedItems)
                            }, label: {
                                HStack {
                                    Text("동아리")
                                        .foregroundColor(.black)
                                    Spacer()
                                    Image(systemName: "\(clubSelectedItems.count).circle")
                                        .foregroundColor(.black)
                                        .font(.title2)
                                }
                            })
                            Spacer()
                            
                            // checkbox
                            Toggle("개인정보 수집에 동의합니다.", isOn: $emailUpdate)
                                .foregroundColor(.black)
                                .font(.system(size: 15))
                                .toggleStyle(CheckboxStyle())
                                .padding()
                            
                            // sign up button
                            Button(action: {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
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
                                        let user = LoginRequest(user_id: emailAddress, user_pw: password)
                                        let major = getMajorSelected(majorSelectedItems: majorSelectedItems)
                                        let club = getClubSelected(clubSelectedItems: clubSelectedItems)
                                        
                                        let phoneNumber = phoneformat(num: tmpPhoneNumber)
                                        
                                        let req = RegisterRequest(name: fullName, user: user, department: major, circle: club, phoneNumber: phoneNumber)
                                        
                                        postRegister.postRegister(registerReq: req)
                                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                                            if(postRegister.res.statusCode == 200) {
                                            STATE = 1
                                            }
                                            else if(postRegister.res.statusCode == 409) {
                                                print("here")
                                                showingToast = true
                                                showingToastTitle = "회원가입 오류"
                                                showingToastMessage = "이미 존재하는 이메일입니다."
                                            }
                                        }
                                    }
                                }
                                
                            }){
                                Text("회원가입 하기")
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
                Spacer()
            }
            .edgesIgnoringSafeArea(.all)
            .navigationTitle("회원가입")
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
        SignUpView(clubSelectedItems: [], majorSelectedItems: [])
    }
}
